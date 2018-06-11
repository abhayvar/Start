waist=zeros(4,4);
rleg=zeros(4,3);
lleg=zeros(4,3);
xcom=zeros(4,1);
h=30*cos(pi*18/180);
langle=zeros(3);
rangle=zeros(3);
zmp=zeros(4,1);

    for t=1:100
        x=(t)/10;
        if (t>-1) && (t<41) % DSP1
            y=-(3*t)/40;
            xa = -5;
            ha = 0;
            lp=[-15,10,0,1];
            rp=[-5,0,0,1];
        elseif (t>40) && (t<81) % SSP1
            y = -3;
            xa = (20/4)*(x-4) - 5;
            ha = 0.00237671*(xa)^3 -0.0582294*(xa)^2 + 0.16637*(xa) + 2.58467;
            lp=[-10+xa,10,ha,1];
            rp=[-5,0,0,1];
        else % DSP2
            y = 3*(t-80)/20 - 3;
            xa = 15;
            ha = 0;
            lp=[5,10,0,1];
            rp=[-5,0,0,1];
        end
        xcom=x;
        ycom = 5+y;
        langles(1)=atan(-y/h);
        [langles(2),langles(3)]=find_angles(xa, ha, x, h, 15);
        rangles(1)=atan(-y/h);
        [rangles(2),rangles(3)]=find_angles(xa, ha, x, h, 15);
        
        rleg=find_leg(rp,rangles);
        lleg=find_leg(lp,langles);
        waist(:,3) = rleg(:,1);
        waist(:,4) = lleg(:,1);
        for i=(1:4)
            waist(i,2)=(rleg(i,1)+lleg(i,1))/2;
        end
        waist(:,1) = waist(:,2);
        waist(3,1) = 25 + waist(3,2);
        zmp(:,1)=waist(:,2);
        zmp(3,1)=0;
        plotfinal(rleg,lleg,waist,zmp);
        pause(.5);
    end 