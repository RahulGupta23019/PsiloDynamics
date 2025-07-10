MainPath='C:\Users\xv20319\OneDrive - University of Bristol\Documents\MATLAB\Psilocybin\';
dt=0.020;%in sec. Change to the dt value you choose.

Drugs={'Saline','Psilocybin_03mg','Psilocybin_1mg'};
Rats={'S','T','U','V'};
BrainReg={'Inf','Pre','Cing'};
States={'Base','Act_Base','Pstdrg2','Act_Pstdrg1','Pstdrg3','Act_Pstdrg2'};
CellTyp={'Py','NS','WS'};

msd=cell(length(Drugs),length(Rats));

for drug=1:length(Drugs)
    for rat=1:length(Rats)
        SubPath1=[Drugs{drug},'\Rat ',Rats{rat},'\'];
        SubPath2='SpkMatrix\';
        
        state_msd=cell(1,length(States));
        for state=1:length(States)
            SpikeMatrix_store=[];
            FileFound=ones(length(BrainReg),length(CellTyp));
            for BR=1:length(BrainReg)
                for CT=1:length(CellTyp)
                    try 
                        filename=[MainPath,SubPath1,SubPath2,States{state},'_',BrainReg{BR},'_',CellTyp{CT},'_dt',num2str(1000*dt,'%d'),'ms.mat'];%check for which dt-binned spike matrix 
                        load(filename);
                        SpikeMatrix_store=[SpikeMatrix_store;SpikeMatrix];
                    catch ME
                        fprintf('Error message: %s\n', ME.message);
                        FileFound(BR,CT)=0;
                    end
                end
            end
                
            if sum(sum(FileFound,1))>0
                BinaryMatrix=SpikeMatrix_store;
                BinaryMatrix(BinaryMatrix>=1)=1;

                deltaT_i=1;%the size of TR becomes (deltaT_i*20ms).
                deltaT_n=1:50;%the maximum limit to which reference will be compared is deltaT_n*(deltaT_i*20ms):deltaT_n is number of TRs 
                Statelength=size(BinaryMatrix,2)-(deltaT_n(end)*deltaT_i);
                MSD=zeros(length(deltaT_n),Statelength);

                for ii=1:length(deltaT_n)
                    for jj=1:Statelength
                        MSD(ii,jj)=mean((BinaryMatrix(:,jj)-BinaryMatrix(:,jj+(deltaT_n(ii)*deltaT_i))).^2);
                        if MSD(ii,jj)==0
                            MSD(ii,jj)=1e-12;
                        end
                    end
                end

                state_msd{state}=mean(MSD,1);
            end
        end
        
        msd{drug,rat}=state_msd;
        
    end
end
