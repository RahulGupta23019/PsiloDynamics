%% Compute the means and standard deviations of the distribution of MSD
% for the drug, state and rat combinations.
% Save the MSD data in a new format (drugsXstatesXrats).
Means=zeros(3,4,4);%(drugs;states:Rest_Pre,Act_Pre,Rest_Post,Act_Post;rats);
Sigmas=zeros(3,4,4);
MSDs=cell(3,4,4);
for drug=1:3
    for rat=1:4
        state_msd=msd_PstdrgAvgd{drug,rat};
        for state=1:4
            Means(drug,state,rat)=mean(state_msd{state});        
            Sigmas(drug,state,rat)=std(state_msd{state});
            MSDs{drug,state,rat}=state_msd{state};
        end
    end
end

%% Adjust the postdrug resting and active state MSD distributions by the mean
% and standard deviations of the predrug resting and active state MSD
% distributions, respectively.
MSDs_Adjustd=cell(3,4,4);
for drug=1:3
        for rat=1:4
            MSDs_Adjustd{drug,1,rat}=(MSDs{drug,1,rat}-Means(drug,1,rat))./Sigmas(drug,1,rat);
            MSDs_Adjustd{drug,2,rat}=(MSDs{drug,2,rat}-Means(drug,2,rat))./Sigmas(drug,2,rat);
            MSDs_Adjustd{drug,3,rat}=(MSDs{drug,3,rat}-Means(drug,1,rat))./Sigmas(drug,1,rat);
            MSDs_Adjustd{drug,4,rat}=(MSDs{drug,4,rat}-Means(drug,2,rat))./Sigmas(drug,2,rat);
        end
end

%% Pool the MSD distributions across rats together to obtain a new MSD data
% in the format drugsXstates
MSDs_RatPooled=cell(3,4);
for drug=1:3
    for state=1:4
        for rat=1:4
            MSDs_RatPooled{drug,state}=[MSDs_RatPooled{drug,state},MSDs_Adjustd{drug,state,rat}];
        end
    end
end

