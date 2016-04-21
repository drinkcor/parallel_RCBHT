function testForRealTimeComingData
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    global globalIndex;
    global Wrench;
    global Wrench_new;
    
    globalIndex = 0;
    Wrench      = zeros(1000,7);
    Wrench_new  = zeros(1,6);
    
    localIndex  =0;
    Wren_loc    = zeros(1000,7);
    
    rosshutdown;
    rosinit;
    
    pub = rospublisher('/robot/limb/right/endpoint_state', 'baxter_core_msgs/EndpointState');
    
    wrenchHandle  = rossubscriber('/robot/limb/right/endpoint_state',@wrenchCallback, 'BufferSize', 1000);
    % wrench_node_sub = robotics.ros.Node('/wrench_node_subscriber');
    % wrenchHandle    = robotics.ros.Subscriber(wrench_node_sub,'/robot/limb/right/endpoint_state','baxter_core_msgs/EndpointState',@wrenchCallback, 'BufferSize', 1);
    % job = batch('wrench_callback_script');
    
    % Delete any possible existing pools running previously
    delete(gcp);
    parpool(2);
    
     while(1)     
        while (localIndex<globalIndex)
            % Increase Counter for local index
            localIndex=localIndex+1;
            
            Wren_loc(localIndex,2:7)  = Wrench(localIndex,2:7);                      
            %Wren_loc_new = Wrench_new;
            
            fprintf('\tGlobalIndex: %8f\tLocalIndex: %8f\n',globalIndex,localIndex);
            % WrenchHandle.LatestMessage;
        
            parfor idx = 2:3
                fprintf('\tWren_loc(%1.0f', idx)
                fprintf(') = %8.4f', Wren_loc(localIndex,idx));
            end
            drawnow;
        end 
        drawnow;
         a=input('please input the centure a: ');
         if(a==2)
             break;
         end
     end
     
      plot(1:localIndex,Wren_loc(:,2));
      hold on;
      plot(1:localIndex,Wren_loc(:,3));
      plot(1:localIndex,Wren_loc(:,4));
      
      save('Wren_loc.mat','Wren_loc');
    
end

