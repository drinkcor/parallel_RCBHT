function testForRealTimeComingData
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    global updated;
    global dataIndex;
    global Wrench;
    global Wrench_new;

    updated = 0;
    dataIndex = 1;
    Wrench = zeros(1000,7);
    Wrench_new = zeros(1,6);
    
    Wren_loc = zeros(1000,7);
    Wren_loc_new = zeros(1,6);
    index = 1;
    % rosshutdown;
    rosinit;
    WrenchHandle = rossubscriber('/robot/limb/right/endpoint_state',@WrenchCallback, 'BufferSize', 100);
    
    % Delete any possible existing pools running previously
    delete(gcp);
    parpool(2);
    
     while(1)             
        while (updated)
            Wren_loc = Wrench;
            Wren_loc_new = Wrench_new;
            index = dataIndex;
            fprintf('\tNumber: %8f\n',index);
            % WrenchHandle.LatestMessage;
        
            parfor idx = 1:2
                fprintf('\tWren_loc(%1.0f', idx)
                fprintf(') = %8.4f', Wren_loc(index,idx));
            end
            updated = 0;
        end
     end
    
end

