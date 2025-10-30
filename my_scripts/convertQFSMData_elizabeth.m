function [qfsmFlow] = convertQFSMData(dirName, fileName, extension, numFrames)

% % % Converts output of QFSM to format I use in subsequent analysis
% % % Inputs 
% % % dirName     :       string
% % %                     location of folder that contains QFSM outputs 
% % % fileName    :       string 
% % %                     base name of file 
% % %                     (ex: e1)
% % % extension   :       string 
% % %                     I used this to denote what phase the the video occured at 
% % %                     (ex: _maint)
% % % numFrames   :       int 
% % %                     number of frames with corresponding PIV field 
% % %                     (ex: if video is 61 frames, numFrames = 60)
% % % Outputs 
% % % qfsmFlow    :       struct with following fields 
% % %                     frame 
% % %                     X location of vector 
% % %                     Y location of vector 
% % %                     U, x velocity component 
% % %                     V, y velocity component 
% % %                     theta, angle of velocity vector 
% % %                     r, magnitude of velocity vector 
                   



    flowDirName = (dirName + "QFSMPackage/flow/" + fileName + "_" + extension + "/")
    
    qfsmFlow = []; 
    count = 1; 
    for f = 1:numFrames

        load(flowDirName + "flow" + num2str(f) + ".mat")
        size(flow)

        for j = 1:length(flow)

            
            qfsmFlow(count).frame = f; 
            qfsmFlow(count).X = flow(j,2); 
            qfsmFlow(count).Y = flow(j,1); 
            qfsmFlow(count).U = (flow(j,4) - flow(j,2))*6; %multiply by 6 to conver to um/min
            qfsmFlow(count).V = (flow(j,3) - flow(j,1))*6; 
            qfsmFlow(count).theta = atan2(qfsmFlow(count).V, qfsmFlow(count).U); 
            qfsmFlow(count).r = sqrt(qfsmFlow(count).V^2 + qfsmFlow(count).U^2); 
    
            count = count+1; 
        end  
        clear flow
    end

end
