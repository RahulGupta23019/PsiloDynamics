msd_PstdrgAvgd=cell(size(msd,1),size(msd,2));

for drug=1:size(msd,1)
    for rat=1:size(msd,2)
            state_msd=msd{drug,rat};
            %from States={'Base','Act_Base','Pstdrg2','Act_Pstdrg1','Pstdrg3','Act_Pstdrg2'} 
            %to {'Base','Act_Base','Avg:Pstdrg2&Pstdrg3','Avg:Act_Pstdrg1&Act_Pstdrg2'};
            state_msd_PstdrgAvgd=cell(1,4);
            state_msd_PstdrgAvgd{1}=state_msd{1};
            state_msd_PstdrgAvgd{2}=state_msd{2};
            state_msd_PstdrgAvgd{3}=(state_msd{3}+state_msd{5})./2;
            state_msd_PstdrgAvgd{4}=(state_msd{4}+state_msd{6})./2;
            
            msd_PstdrgAvgd{drug,rat}=state_msd_PstdrgAvgd;
    end
end

clearvars -except msd msd_PstdrgAvgd;