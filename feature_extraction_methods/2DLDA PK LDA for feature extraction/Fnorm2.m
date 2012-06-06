function ErrorRates= Fnorm2(TrainSet,TrainLabel,TestSet,TestLabel, R,r,c)


%Frobinor measures for one-sided 2DLDA 


 % see Liang et al ."A note on two-dimensional linear discriminant analysis," Pattern Recogntion Letter
  % TrainSet denotes the traning set  and each column is a data point
    %TrainLabel is the label of tranining set and is a colunm vector(such as 1 denotes the 1th class and so on.
   % TestSet denotes the tesing set and each column is a data point. 
  %TestLabel denotes the label of testing set and is stored like TrainLabel 
  %r is the number of rows for each image  and c is the number of cloumns of each image
% note that  r and c is the image size. such as 32*32 images
 % R is the right projected vectors 

   [m1,n1]=size(TrainSet);
   [m2,n2]=size(TestSet);
   [m3,n3]=size(R);
   CC=[];
   DD=[];
   if n3>1
        for i=1:n1
       Temp=reshape(TrainSet(:,i), r,c);
       CC(:,:,i)=Temp'*R;
        end
         for j=1:n2
         Temp=reshape(TestSet(:,j), r,c);
          DD(:,:,j)=Temp'*R;
         end
         [m4,n4]=size(Temp);
         A1=0;
        for i=1:n2
            ff1=DD(:,:,i);
                  TempStore=zeros(n1,1);
                  
                  for j=1:n1
                      ff2=CC(:,:,j);
                          tempvalue=0;
                          %compute AMD
                         ff3=ff1-ff2;
                         tempvalue=norm(ff3, 'fro');
                            
                         TempStore(j,1)=tempvalue;
                  end
                   [B,IX]=sort(TempStore);
             TempLabel =TrainLabel(IX(1,1),1);
            if TestLabel(i,1)~=TempLabel;
                A1=A1+1;
            end
           
        end 
        ErrorRates=A1/n2;
   else
        for i=1:n1
       Temp=reshape(TrainSet(:,i), r,c);
       CC(:,i)=Temp'*R;
        end
         for j=1:n2
         Temp=reshape(TestSet(:,j), r,c);
          DD(:,j)=Temp'*R;
         end
         [m4,n4]=size(Temp);
         A1=0;
        for i=1:n2
            ff1=DD(:,i);
                  TempStore=zeros(n1,1);
                  
                  for j=1:n1
                      ff2=CC(:,j);
                          tempvalue=0;
                          %compute AMD
                         ff3=ff1-ff2;
                            Y=(ff3);
                            tempvalue=norm(Y);
                         TempStore(j,1)=tempvalue;
                  end
                   [B,IX]=sort(TempStore);
             TempLabel =TrainLabel(IX(1,1),1);
            if TestLabel(i,1)~=TempLabel;
                A1=A1+1;
            end
           
        end 
        ErrorRates=A1/n2;
   end