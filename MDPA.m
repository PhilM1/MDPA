
springConst = 1;
timestep = 0.1;
numParticles = 5;
particleArray = [1, 0, 1;
                 2, 0, 1
                 3, 0, 1
                 4, 0, 1
                 5, 0, 1];
x0Dist = 0.5;
y = ones(1,5);
timeCount = 0;
while(1)
    timeCount = timeCount + 1;
    %update velocities
    for i = 1:numParticles
        
        F1 = 0;
        F2 = 0;      
        
        if(i ~= 1) %Left Side force
            pDiff = abs(particleArray(i-1,1) - particleArray(i,1));
            F1 = springConst*(pDiff-x0Dist)^2;
            if(pDiff > x0Dist)
                F1 = -F1;
            end
        end
        
        if(i ~= numParticles) %Right Side force
            pDiff2 = abs(particleArray(i+1,1) - particleArray(i,1));
            F2 = springConst*(pDiff2-x0Dist)^2;
            if(pDiff2 < x0Dist)
                F2 = -F2;
            end
        end
        
        %time to update velocities
        F_total = F1 + F2;
        accel = F_total/particleArray(i,3);
        newV = particleArray(i,2) + accel*timestep;
        particleArray(i,2) = newV;
    end
    
    %update positions
    for i = 1:numParticles
        newPos = particleArray(i,1) + particleArray(i,2)*timestep;
        particleArray(i,1) = newPos;
    end
    
    particleArray
    
    %add perturbation at 10secs
    if( timeCount*timestep == 10)
        particleArray(5,2) = particleArray(i,2) + 1;
    end
    
    scatter(particleArray(:,1), y, 'filled');
    title(['Current Time: ', num2str(timeCount*timestep)]);
    xlim([0,10]);
    pause(timestep);
end
