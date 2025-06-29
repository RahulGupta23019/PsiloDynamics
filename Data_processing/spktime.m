function spk=spktime(suaNo,sp)

spk=cell(length(suaNo),1);
for i=1:length(suaNo)
    spk{i}=sp.st(sp.clu==sp.cids(suaNo(i)));
end