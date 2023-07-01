function EbruGraph2(Info,p)
% EbruGraph2(info,30)
Xopt = zeros(p*3,6);
MVopt= zeros(p*3,6);

% take all 3 set of solutions into a single one
for a =1:3
    Xopt((a-1)*p+1:a*p,:) = Info(a).Xopt(1:p,:);
    MVopt((a-1)*p+1:a*p,:) = Info(a).MVopt(1:p,:);
end

f = figure;
ylim([-1, 11]);
xlim([-1, 11.5]);

% picture needs to be taken upside down
img = imread('daglardereler.png');
img = flipud(img);

rt1 = 2;
sz1 = 0.7;

% motor 1 and 2
rt2 = 3;  sz2 = 0.3;

% motor 3
rt3 = 1/3;

n = size(Xopt,1);
xm1 = 0.4;
xm2 = 0;
xm3 = 0.4; %originally 0.2 but for aestetic purposes...
ym3 = 0.2; %originally 0.2 but for aestetic purposes...

for eb=1:n
    cla(f)
    x  = Xopt(eb,1);
    y  = Xopt(eb,2);
    th = Xopt(eb,3);

    th1 = MVopt(eb,4);
    th2 = MVopt(eb,5);
    th3 = MVopt(eb,6);

    lf = [cos(atan(rt1)-th)*sz1 sin(atan(rt1)-th)*sz1];
    rf = [cos(atan(-rt1)-th)*sz1 sin(atan(-rt1)-th)*sz1];
    lr = [cos(pi-atan(rt1)-th)*sz1 sin(pi-atan(rt1)-th)*sz1];
    rr = [cos(pi-atan(-rt1)-th)*sz1 sin(pi-atan(-rt1)-th)*sz1];

    patch(x+[lf(1) rf(1) rr(1) lr(1)],...
          y+[lf(2) rf(2) rr(2) lr(2)],...
          'y',...
          'FaceAlpha',0.5); %'LineStyle',':'
    
    % line to present the shoulder line
    line([lr(1) lf(1)]+x,[lr(2) lf(2)]+y,'color','r');
    
    % text to write 3 states
    txt = ['x,y,theta: ' num2str(round(x)) ', ' num2str(round(y)) ', ' num2str(round(th/pi*180))];
    text(4,0.5,txt)

    % text to write 3 control angles
    txt2 = ['th1: ' num2str(round(th1/pi*180))];
    text(4,2.5,txt2)
    txt3 = ['th2: ' num2str(round(th2/pi*180))];
    text(4,2,txt3)
    txt4 = ['th3: ' num2str(round(th3/pi*180))];
    text(4,1.5,txt4)

    % draw first motor
    x1  = x - xm1*cos(th);
    y1  = y + xm1*sin(th);
    lf1 = [cos(atan(rt2)-th-th1)*sz2 sin(atan(rt2)-th-th1)*sz2];
    rf1 = [cos(atan(-rt2)-th-th1)*sz2 sin(atan(-rt2)-th-th1)*sz2];
    lr1 = [cos(pi-atan(rt2)-th-th1)*sz2 sin(pi-atan(rt2)-th-th1)*sz2];
    rr1 = [cos(pi-atan(-rt2)-th-th1)*sz2 sin(pi-atan(-rt2)-th-th1)*sz2];
    patch(x1+[lf1(1) rf1(1) rr1(1) lr1(1)],...
          y1+[lf1(2) rf1(2) rr1(2) lr1(2)],...
          'k',...
          'FaceAlpha',0.5);

    % draw second motor
    x2  = x - xm2*cos(th);
    y2  = y + xm2*sin(th);
    lf2 = [cos(atan(rt2)-th-th2)*sz2 sin(atan(rt2)-th-th2)*sz2];
    rf2 = [cos(atan(-rt2)-th-th2)*sz2 sin(atan(-rt2)-th-th2)*sz2];
    lr2 = [cos(pi-atan(rt2)-th-th2)*sz2 sin(pi-atan(rt2)-th-th2)*sz2];
    rr2 = [cos(pi-atan(-rt2)-th-th2)*sz2 sin(pi-atan(-rt2)-th-th2)*sz2];
    patch(x2+[lf2(1) rf2(1) rr2(1) lr2(1)],...
          y2+[lf2(2) rf2(2) rr2(2) lr2(2)],...
          'k',...
          'FaceAlpha',0.5);

    % draw third motor
    x3  = x + xm3*cos(th) + xm3*sin(th);
    y3  = y - xm3*sin(th) + ym3*cos(th);
    lf3 = [cos(atan(rt3)-th-th3)*sz2 sin(atan(rt3)-th-th3)*sz2];
    rf3 = [cos(atan(-rt3)-th-th3)*sz2 sin(atan(-rt3)-th-th3)*sz2];
    lr3 = [cos(pi-atan(rt3)-th-th3)*sz2 sin(pi-atan(rt3)-th-th3)*sz2];
    rr3 = [cos(pi-atan(-rt3)-th-th3)*sz2 sin(pi-atan(-rt3)-th-th3)*sz2];
    patch(x3+[lf3(1) rf3(1) rr3(1) lr3(1)],...
          y3+[lf3(2) rf3(2) rr3(2) lr3(2)],...
          'k',...
          'FaceAlpha',0.5);

    % add picture with coordinates from...to... format.
    image('CData',img,'XData',[1.2 8.8],'YData',[-1 8])
    hold on;
    
    pause(0.1)
end
end