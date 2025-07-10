load('UnitWise.mat');
Drugs={'Sal','Psl03mg','Psl1mg'};
Rats={'S','T','U','V'};
BrainReg={'Inf','Pre','Cing'};
States={'R0','A0','R2','A1','R3','A2'};
CellTyp={'Py','NS','WS'};

C{1,1}='Unit ID';
C{1,2}='Drug';
C{1,3}='Rat';
C{1,4}='State';
C{1,5}='BR';
C{1,6}='CT';
C{1,7}='LZ';

for state=1:length(States)
    Nneur=1;
    for drug=1:length(Drugs)
        for rat=1:length(Rats)
            for BR=1:length(BrainReg)
                for CT=1:length(CellTyp)
                    Cvec=complexity{drug,rat,BR,CT}{state};
                    if ~isempty(Cvec)
                        for N=1:length(Cvec)
                            Ctemp{1,1}=Nneur;
                            Ctemp{1,2}=Drugs{drug};
                            Ctemp{1,3}=Rats{rat};
                            Ctemp{1,4}=States{state};
                            Ctemp{1,5}=BrainReg{BR};
                            Ctemp{1,6}=CellTyp{CT};
                            Ctemp{1,7}=Cvec(N);
                            
                            C=[C;Ctemp];
                            
                            Nneur=Nneur+1;
                        end
                    end
                end
            end
        end
    end
end
T=cell2table(C);
writetable(T,'UnitLZ.xls');
