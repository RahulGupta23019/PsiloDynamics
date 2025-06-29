MainPath='C:\Users\xv20319\OneDrive - University of Bristol\Documents\MATLAB\Psilocybin\';

Drugs={'Saline_day0','Psilocybin_day0','Psilocybin_1mg'};
Rats={'S','T','U','V'};
States={'Base','Act_Base','Pstdrg1','Pstdrg2','Act_Pstdrg1','Pstdrg3','Act_Pstdrg2'};
BrainReg={'Inf','Pre','Cing'};
CellTyp={'Py','NS','WS'};

dt=0.020;%in sec. Replace with 0.010 for 10ms time bin.

for drug=1:length(Drugs)
    for rat=1:length(Rats)
        SubPath1=[Drugs{drug},'\Rat ',Rats{rat},'\'];
        SubPath2='ExtractdData_AllenFiltrd\';
        SubPath3='SpkMatrix_AllenFiltrd\';
        
        load([MainPath,SubPath1,'events_bsl.mat']);
        load([MainPath,SubPath1,'events_vi.mat']);
    
        Ti=[block_Rts_bsl,block_Ats_bsl,block_Rts(1),block_Rts(2),block_Ats(1),block_Rts(3),block_Ats(2)];%s
        Tf=[block_Ats_bsl,block_Fts_bsl,block_Rts(2),block_Ats(1),block_Rts(3),block_Ats(2),block_Ats(2)+900];%s
        
        for state=1:length(States)
            for BR=1:length(BrainReg)
                for CT=1:length(CellTyp)
                    filename=[MainPath,SubPath1,SubPath2,States{state},'_',BrainReg{BR},'_',CellTyp{CT},'.mat'];
                    load(filename);                
                    if ~isempty(SpkTm)
                        SpikeMatrix=bin_data(SpkTm,Ti(state),dt);
                        filename=[MainPath,SubPath1,SubPath3,States{state},'_',BrainReg{BR},'_',CellTyp{CT},'_dt20ms.mat'];%change the label to 10ms for timebin 0.010s.
                        save(filename,'SpikeMatrix');
                    end
                end
            end
        end
        
    end
end

