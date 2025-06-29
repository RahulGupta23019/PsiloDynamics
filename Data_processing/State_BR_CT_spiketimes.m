MainPath='C:\Users\xv20319\OneDrive - University of Bristol\Documents\MATLAB\Psilocybin\';% Change this based on where the data is saved locally.

Drugs={'Saline_day0','Psilocybin_day0','Psilocybin_1mg'};
Rats={'S','T','U','V'};
States={'Base','Act_Base','Pstdrg1','Pstdrg2','Act_Pstdrg1','Pstdrg3','Act_Pstdrg2'};
BrainReg={'Inf','Pre','Cing'};
CellTyp={'Py','NS','WS'};

for drugs=1:length(Drugs)
    for rats=1:length(Rats)
        SubPath1=[Drugs{drugs},'\Rat ',Rats{rats},'\'];
        SubPath2='ExtractdData\';
        
        load([MainPath,SubPath1,'events_bsl.mat']);
        load([MainPath,SubPath1,'events_vi.mat']);
     
        Ti=[block_Rts_bsl,block_Ats_bsl,block_Rts(1),block_Rts(2),block_Ats(1),block_Rts(3),block_Ats(2)];% in sec.
        Tf=[block_Ats_bsl,block_Fts_bsl,block_Rts(2),block_Ats(1),block_Rts(3),block_Ats(2),block_Ats(2)+900];%in sec.
        
        for BR=1:length(BrainReg)
            for CT=1:length(CellTyp)
                load([MainPath,SubPath1,SubPath2,'SpTm_',BrainReg{BR},'_',CellTyp{CT},'.mat']);
                SpkTm=cell(length(SpTm),1);
                for state=1:length(States)
                    for i_n=1:length(SpTm)
                        Spk=SpTm{i_n};
                        SpkTm{i_n}=Spk(logical((Spk>=Ti(state)).*(Spk<Tf(state))));
                    end
                    filename=[MainPath,SubPath1,SubPath2,States{state},'_',BrainReg{BR},'_',CellTyp{CT},'.mat'];
                    save(filename,'SpkTm');
                end
            end
        end
    end
        
end
