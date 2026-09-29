function drawLayout(X0, Y0, X1, Y1)
    k=0.2;
    for i=1:length(X0)
        rectangle('Position', [X0(i)+0.5, Y0(i)+0.5, (X1(i)-X0(i)), (Y1(i)-Y0(i))], 'FaceColor',[.9 .9 1]);
        %rectangle('Position', [X0(i)+0.5+k, Y0(i)+0.5+k, (X1(i)-X0(i))-2*k, (Y1(i)-Y0(i))-2*k], 'Curvature',1, 'FaceColor',[.8 .8 1], 'EdgeColor', [.7 .7 1]);
    end
end 