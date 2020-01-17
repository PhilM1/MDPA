
springConst = 1;
timestep = 0.1;
numParticles = 2;
particleArray = [1, 0, 1;
                 2, 0, 1];
x0Dist = 0.5;
y = [1, 1];
             
while(1)
    
    %update velocities
    for i = 1:numParticles
        
        F1 = 0;
        F2 = 0;      
        
        if(i ~= 1) %Left Side
            pDiff = abs(particleArray(i-1,1) - particleArray(i,1));
            F1 = springConst*(pDiff-x0Dist)^2;
            if(pDiff < x0Dist)
                F1 = -F1;
            end
        end
        
        if(i ~= numParticles) %Right Side
            pDiff = abs(particleArray(i+1,1) - particleArray(i,1));
            F2 = springConst*(pDiff-x0Dist)^2;
            if(pDiff > x0Dist)
                F2 = -F2;
            end
        end
        
        %time to update velocities
        F_total = F1 + F2;
        accel = F1/particleArray(i,3);
        newV = particleArray(i,2) + accel*timestep;
        particleArray(i,2) = newV;
    end
    
    %update positions
    for i = 1:numParticles
        newPos = particleArray(i,1) + particleArray(i,2)*timestep;
        particleArray(i,1) = newPos;
    end
    
    particleArray
    
    scatter(particleArray(:,1), y, 'filled');
    pause(1)
end
