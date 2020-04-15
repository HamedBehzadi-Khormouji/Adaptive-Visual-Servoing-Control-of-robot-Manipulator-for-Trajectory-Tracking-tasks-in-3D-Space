%% FUNCTION FOR DEPTH NORMALIZATION OF A KINECT RGB-D IMAGE IN REAL-TIME
% Fills in all '0' depth values in an RGB-D depth image (16-bit png) 
% from Kinect with statistical mode of the surrounding 25 values. 
% The code is a matlab version of the algorithm used by Karl Sanford at
% Code Project
% (http://www.codeproject.com/Articles/317974/KinectDepthSmoothing)
% ----------------------------------------------------------------------
% Theory:
% The kinect depth image has pixels with values equal to the calculated 
% depth of object/surface in view. However, areas that absorb or scatter
% the kinect IR (like glossy surfaces or sharp edges) are filled with
% zero pixel value (indicating non-calculated depth). These regions with 
% the missing information, represented by zero values, need to be filled 
% prior to using the depth images. This filling process is done by 
% replacing the zero value pixels with the statistical mode of the 
% surrounding 25 pixels. Using a statistical mode returns sharper edges 
% than using statistical mean values, since mode only inserts the maximum 
% occurring value in the surrounding 25 pixels to the centre pixel. 
% ----------------------------------------------------------------------
% Usage: [Q,R] = Kinect_DepthNormalization(depthImage)
% Function Input: Kinect depth image (16-bit png)
% Function Output: depth image with zero valued replaced , Number of 
% zero pixels detected in the image.
% ----------------------------------------------------------------------


function [filledDepth, zeroPixels] = Kinect_DepthNormalization (depthImage)

    [row,col] = size(depthImage);
    widthBound = row-1;
    heightBound = col-1;

    % initializing working image; leave original matrix aside
    filledDepth = depthImage;

    %initializing the filter matrix
    filterBlock5x5 = zeros(5,5);
    
    % to keep count of zero pixels found
    zeroPixels = 0;
    
    %The main loop
    for x=1 : row
        for y=1 : col        
            %Only for pixels with 0 depth value; else skip
            if filledDepth(x,y) == 0;
                zeroPixels = zeroPixels+1;
                % values set to identify a positive filter result.
                 p = 1;
                % Taking a cube of 5x5 around the 0 depth pixel
                % q = index
                % select two pixels behind and two ahead in a row
                % select two pixels behind and two ahead in a column
                % leave the center pixel (as its the one to be filled)
                for xi = -2 : 1 : 2;
                    q = 1;
                    for yi = -2 : 1 : 2;
                        % updating index for next pass
                        xSearch = x + xi; 
                        ySearch = y + yi;
                        % xSearch and ySearch to avoid edges
                        if (xSearch > 0 && xSearch < widthBound && ySearch > 0 && ySearch < heightBound)
                            % save values from depth image into filter
                            filterBlock5x5(p,q) = filledDepth(xSearch,ySearch);
                        end
                        q = q+1;
                    end
                    p = p+1;
                end
                % Now that we have the 5x5 filter, with values surrounding
                % the zero valued fixel, in 'filterBlock5x5' ; we can now
                % Calculate statistical mode of the 5x5 matrix
                X = sort(filterBlock5x5(:));
                % find all non-zero entries in the sorted filter block 
                [~,~,v] = find(X);
                % indices where repeated values change
                if (isempty(v));
                    filledDepth(x,y) = 0;
                else
                    indices   =  find(diff([v; realmax]) > 0);
                    % finding longest persistent length of repeated values
                    [~,i] =  max (diff([0; indices]));     
                    % The value that is repeated is the mode
                    mode      =  v(indices(i));

                    % fill in the x,y value with the statistical mode of the values
                    filledDepth(x,y) = mode;
                end
            end
        end
    % end for
    end
return;
end