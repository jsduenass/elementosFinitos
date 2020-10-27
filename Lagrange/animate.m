%% write video
function animate(fileName,imgs,Fps)

    writerObj = VideoWriter(fileName,'MPEG-4');
    writerObj.FrameRate = Fps;
    % open the video writer
    open(writerObj);

    % write the frames to the video
    for id=1:length(imgs)
        % convert the image to a frame
        frame2 = imgs(id) ;    
        writeVideo(writerObj, frame2);

    end
    
    % close the writer object
    close(writerObj);
end