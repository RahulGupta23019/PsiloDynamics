function SpkMatrix=bin_data(SpkTm,Ti,dt)

Nneurons=length(SpkTm);
Nbins=900/dt;

SpkMatrix=zeros(Nneurons,Nbins);

for ii=1:Nneurons
    Ti_tmp=Ti;
    SpkVec=SpkTm{ii};
    for jj=1:Nbins
        Tf_tmp=Ti_tmp+dt;
        SpkMatrix(ii,jj)=sum((SpkVec>=Ti_tmp).*(SpkVec<Tf_tmp));
        Ti_tmp=Tf_tmp;
    end
end