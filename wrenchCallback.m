% function Wrench = WrenchCallback(~,message)
function WrenchCallback(~,message)
% Subscribe to /robot/limb/right/endpoint_state
% Usage: 
% clear Wrench
% clear dataIndex
%
% global dataIndex
% global Wrench
% global Wrench_new
% 
% dataIndex = 1
% Wrench = zeros(30,7)
%
% WrenchHandle = rossubscriber('/robot/limb/right/	',@WrenchCallback);
%%% chatbuf = rossubscriber('/chatter', 'BufferSize', 5); 

global updated;

global Wrench;
global Wrench_new;

global dataIndex;

   Fx = message.Wrench.Force.X;
   Fy = message.Wrench.Force.Y;
   Fz = message.Wrench.Force.Z;
   Mx = message.Wrench.Torque.X; 
   My = message.Wrench.Torque.Y; 
   Mz = message.Wrench.Torque.Z;  
   
   if(~(Fx==0)||~(Fy==0)||~(Fz==0)||~(Mx==0)||~(My==0)||~(Mz==0)) 
        Wrench_new = [Fx Fy Fz Mx My Mz];
        Wrench(dataIndex,:) = [dataIndex Fx Fy Fz Mx My Mz];
        dataIndex = dataIndex+1;
        updated = 1;
   end
   

end

