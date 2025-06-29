function c = LZC(S)

c=1;pl=1;lc=1;mlc=1;p=0;

while pl+lc<=length(S)
    
    if S(p+lc)==S(pl+lc)
        lc=lc+1;
    else
        mlc=max([lc,mlc]);
        p=p+1;
        
        if p==pl
            c=c+1;
            pl=pl+mlc;
            
            p=0;
            mlc=1;
        end
        
        lc=1;
    end
end

if lc~=1
    c=c+1;
end

end