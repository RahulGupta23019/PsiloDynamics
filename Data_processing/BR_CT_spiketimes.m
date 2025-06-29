%%
%Inf:Infralimbic=3, Pre:Prelimbic=4, Cing:Cingulate cortex=5
%Py:pyramidal neurons=1, NS:narrow spiking interneurons=2, WS:wide spiking interneurons=3
%%
MainPath='C:\Users\xv20319\OneDrive - University of Bristol\Documents\MATLAB\Psilocybin\';% Change this based on where the data is saved locally.

Drugs={'Saline_day0','Psilocybin_day0','Psilocybin_1mg'};
Rats={'S','T','U','V'};
BrainReg={'Inf','Pre','Cing'};
CellTyp={'Py','NS','WS'};

for drug=1:length(Drugs)
    for rat=1:length(Rats)
        SubPath1=[Drugs{drug},'\Rat ',Rats{rat},'\'];
        SubPath2='ExtractdData\';
        load([MainPath,SubPath1,'spikeStruct_CM.mat']);
        load([MainPath,SubPath1,'UnitReg.mat.mat']);
        load([MainPath,SubPath1,'Metrics.mat']);
        
        Total_sua=0;
        
        for BR=1:length(BrainReg)
            for CT=1:length(CellTyp)
                
                %Unfiltered
                %suaNo=UnitReg(logical((UnitReg(:,4)==(ii+2)).*(UnitReg(:,5)==jj)),1);
                %Allen metric filtered
                suaNo=UnitReg(logical(((UnitReg(:,4)==(ii+2)).*(UnitReg(:,5)==jj)).*((metsua(:,4)<0.5).*(metsua(:,6)<.1).*(metsua(:,3)>0.9))),1);
                
                SpTm=spktime(suaNo,sp);
                filename=[MainPath,SubPath1,SubPath2,'SpTm_',BrainReg{BR},'_',CellTyp{CT},'.mat'];save(filename,'SpTm');
                Total_sua=Total_sua+length(SpTm);
            end
        end
    end
end
% disp(Total_sua);