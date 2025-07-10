MainPath='C:\Users\xv20319\OneDrive - University of Bristol\Documents\MATLAB\Psilocybin\';
dt=0.010;%in sec. 

Drugs={'Saline','Psilocybin_03mg','Psilocybin_1mg'};
Rats={'S','T','U','V'};
BrainReg={'Inf','Pre','Cing'};
States={'Base','Act_Base','Pstdrg2','Act_Pstdrg1','Pstdrg3','Act_Pstdrg2'};
CellTyp={'Py','NS','WS'};

complexity=cell(length(Drugs),length(Rats),length(BrainReg),length(CellTyp));

for drug=1:length(Drugs)
    for rat=1:length(Rats)
        SubPath1=[Drugs{drug},'\Rat ',Rats{rat},'\'];
        SubPath2='SpkMatrix_AllenFiltrd\';
        
        for BR=1:length(BrainReg)
            for CT=1:length(CellTyp)
                state_c=cell(1,length(States));
                for state=1:length(States)
                    FileFound=1;
                    try 
                        filename=[MainPath,SubPath1,SubPath2,States{state},'_',BrainReg{BR},'_',CellTyp{CT},'_dt',num2str(1000*dt,'%d'),'ms.mat'];
                        load(filename);
                        c_store=NaN*ones(size(SpikeMatrix,1),1);
                    catch ME
                        fprintf('Error message: %s\n', ME.message);
                        FileFound=0;
                    end
                    
                    if FileFound==1
                        BinaryMatrix=SpikeMatrix;
                        BinaryMatrix(BinaryMatrix>=1)=1;%Converting to binary matrix
                        for row=1:size(BinaryMatrix,1)
                            c=LZC(BinaryMatrix(row,:));
                            c_store(row)=c*log2(size(BinaryMatrix,2))/size(BinaryMatrix,2);
                        end
                        state_c{state}=c_store;
                    end
                end
                
                complexity{drug,rat,BR,CT}=state_c;
                   
            end 
        end
    end
end
