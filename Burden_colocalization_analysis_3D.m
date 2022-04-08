function Burden_colocalization_analysis_3D()


%% Source Files (will convert ALL the .avi in the folder)
srcPath = uigetdir('Select the sequence path'); %Images Location
mkdir(srcPath, [filesep 'Results_burden']);
srcFiles = strcat(srcPath,[filesep '*.tif']);  % the folder in which ur images exists
srcFiles = dir(srcFiles);
[x,y] = size(srcFiles);

prompt = {'Burden channel', 'Channel 1', 'Channel 2', 'Channel 3'};
title = 'Parameters';
definput = {'gfap', 'tau', 'syph',''};
answer = inputdlg(prompt,title,[1 50],definput);
Burden= answer{1};
Channel_1= answer{2};
Channel_2= answer{3};
Channel_3= answer{4};





%% Colocalization between 2 channels

if ((isempty(Channel_1))+(isempty(Channel_2))+(isempty(Channel_3)))==2
    
    % Prepare the table for results
    Table1_combined  = cell2table(cell(0,3),'VariableNames',{'Case',strcat(Burden,'_percent_area'), strcat(Burden,'_with_', Channel_1,'_percent_area')});

    for Files=1:x
        
        if contains (srcFiles(Files).name, Burden)
        disp(strcat('analysing',{' '}, srcFiles(Files).name))
   
        % Load images
        BURDEN = read_stackTiff(strcat(srcPath,'/',srcFiles(Files).name));
        BURDEN = BURDEN > 0;
         
        CHANNEL_1 =  read_stackTiff(strcat(srcPath,filesep, (char(strrep(srcFiles(Files).name, Burden, Channel_1)))));
        CHANNEL_1 = CHANNEL_1 > 0;
        
        % Get case name
        FileName=(char(srcFiles(Files).name));
        FileName=FileName (:,1:end-4);
        
        % Image Area
        Image_area=numel(BURDEN);
               
        % Percent Burden Area
        Burden_area=nnz(BURDEN);
        Percent_burden_area=(Burden_area/Image_area)*100;
        
        % Percent Burden with Channel 1
        Burden_Channel_1= nnz(BURDEN.*CHANNEL_1);
        Percent_burden_Channel_1 =(Burden_Channel_1/Burden_area)*100;
                       
        % Create table       
        Results.(strcat(Burden,'_percent_area'))=Percent_burden_area;
        Results.(strcat(Burden,'_with_', Channel_1,'_percent_area'))=Percent_burden_Channel_1;
        Table1 = struct2table(Results);
        Table1.Case(:)={FileName};   
        Table1 = Table1(:,[3 1 2]);
        Table1_combined =vertcat(Table1,Table1_combined); 
                 
        % Save Excel export                   
        writetable (Table1_combined, (strcat(srcPath,[filesep 'Results_burden' filesep strcat(Burden,'_percent_area.csv')])));
                 
        end  
    end                      
         disp('Done - enjoy! :)')
end

%% Colocalization between 3 channels

if ((isempty(Channel_1))+(isempty(Channel_2))+(isempty(Channel_3)))==1

    % Prepare the table for results
    Table1_combined  = cell2table(cell(0,5),'VariableNames',{'Case',strcat(Burden,'_percent_area'), strcat(Burden,'_with_', Channel_1,'_percent_area')...
                        ,strcat(Burden,'_with_', Channel_2,'_percent_area'),strcat(Burden,'_with_', Channel_1,'_',Channel_2,'_percent_area')});

    for Files=1:x
        
        if contains (srcFiles(Files).name, Burden)
        disp(strcat('analysing',{' '}, srcFiles(Files).name))
   
        % Load images
        BURDEN = read_stackTiff(strcat(srcPath,'/',srcFiles(Files).name));
        BURDEN = BURDEN > 0;
         
        CHANNEL_1 =  read_stackTiff(strcat(srcPath,filesep, (char(strrep(srcFiles(Files).name, Burden, Channel_1)))));
        CHANNEL_1 = CHANNEL_1 > 0;
        
        CHANNEL_2 =  read_stackTiff(strcat(srcPath,filesep, (char(strrep(srcFiles(Files).name, Burden, Channel_2)))));
        CHANNEL_2 = CHANNEL_2 > 0;
        
        % Get case name
        FileName=(char(srcFiles(Files).name));
        FileName=FileName (:,1:end-4);
        
        % Image Area
        Image_area=numel(BURDEN);
               
        % Percent Burden Area
        Burden_area=nnz(BURDEN);
        Percent_burden_area=(Burden_area/Image_area)*100;
        
        % Percent Burden with Channel 1
        Burden_Channel_1= nnz(BURDEN.*CHANNEL_1);
        Percent_burden_Channel_1 =(Burden_Channel_1/Burden_area)*100;
        
        % Percent Burden with Channel 2
        Burden_Channel_2= nnz(BURDEN.*CHANNEL_2);
        Percent_burden_Channel_2 =(Burden_Channel_2/Burden_area)*100;
        
        % Percent Burden with Channel 1 and 2
        Burden_Channel_1_2= nnz(BURDEN.*CHANNEL_1.*CHANNEL_2);
        Percent_burden_Channel_1_2 =(Burden_Channel_1_2/Burden_area)*100;
                       
        % Create table       
        Results.(strcat(Burden,'_percent_area'))=Percent_burden_area;
        Results.(strcat(Burden,'_with_', Channel_1,'_percent_area'))=Percent_burden_Channel_2;
        Results.(strcat(Burden,'_with_', Channel_2,'_percent_area'))=Percent_burden_Channel_1_2;
        Results.(strcat(Burden,'_with_', Channel_1,'_', Channel_2, '_percent_area'))=Percent_burden_Channel_1;
        Table1 = struct2table(Results);
        Table1.Case(:)={FileName};   
        Table1 = Table1(:,[5 1 2 3 4]);
        Table1_combined =vertcat(Table1,Table1_combined); 
                 
        % Save Excel export                   
        writetable (Table1_combined, (strcat(srcPath,[filesep 'Results_burden' filesep strcat(Burden,'_percent_area.csv')])));
                 
        end  
    end                      
         disp('Done - enjoy! :)')
end


%% Colocalization between 4 channels

if ((isempty(Channel_1))+(isempty(Channel_2))+(isempty(Channel_3)))==0

    % Prepare the table for results
    Table1_combined  = cell2table(cell(0,9),'VariableNames',{'Case',strcat(Burden,'_percent_area'), strcat(Burden,'_with_', Channel_1,'_percent_area')...
                        ,strcat(Burden,'_with_', Channel_2,'_percent_area'),strcat(Burden,'_with_', Channel_3,'_percent_area'),...
                        strcat(Burden,'_with_', Channel_1,'_',Channel_2,'_percent_area'),strcat(Burden,'_with_', Channel_1,'_',Channel_3,'_percent_area'),...
                        strcat(Burden,'_with_', Channel_2,'_',Channel_3,'_percent_area'),strcat(Burden,'_with_',Channel_1,'_', Channel_2,'_',Channel_3,'_percent_area')});

    for Files=1:x
        
        if contains (srcFiles(Files).name, Burden)
        disp(strcat('analysing',{' '}, srcFiles(Files).name))
   
        % Load images
        BURDEN = read_stackTiff(strcat(srcPath,'/',srcFiles(Files).name));
        BURDEN = BURDEN > 0;
         
        CHANNEL_1 =  read_stackTiff(strcat(srcPath,filesep, (char(strrep(srcFiles(Files).name, Burden, Channel_1)))));
        CHANNEL_1 = CHANNEL_1 > 0;
        
        CHANNEL_2 =  read_stackTiff(strcat(srcPath,filesep, (char(strrep(srcFiles(Files).name, Burden, Channel_2)))));
        CHANNEL_2 = CHANNEL_2 > 0;
        
        CHANNEL_3 =  read_stackTiff(strcat(srcPath,filesep, (char(strrep(srcFiles(Files).name, Burden, Channel_3)))));
        CHANNEL_3 = CHANNEL_3 > 0;
        
        % Get case name
        FileName=(char(srcFiles(Files).name));
        FileName=FileName (:,1:end-4);
        
        % Image Area
        Image_area=numel(BURDEN);
               
        % Percent Burden Area
        Burden_area=nnz(BURDEN);
        Percent_burden_area=(Burden_area/Image_area)*100;
        
        % Percent Burden with Channel 1
        Burden_Channel_1= nnz(BURDEN.*CHANNEL_1);
        Percent_burden_Channel_1 =(Burden_Channel_1/Burden_area)*100;
        
        % Percent Burden with Channel 2
        Burden_Channel_2= nnz(BURDEN.*CHANNEL_2);
        Percent_burden_Channel_2 =(Burden_Channel_2/Burden_area)*100;
        
        % Percent Burden with Channel 3
        Burden_Channel_3= nnz(BURDEN.*CHANNEL_3);
        Percent_burden_Channel_3 =(Burden_Channel_3/Burden_area)*100;
        
        % Percent Burden with Channel 1 and 2
        Burden_Channel_1_2= nnz(BURDEN.*CHANNEL_1.*CHANNEL_2);
        Percent_burden_Channel_1_2 =(Burden_Channel_1_2/Burden_area)*100;
        
        % Percent Burden with Channel 1 and 3
        Burden_Channel_1_3= nnz(BURDEN.*CHANNEL_1.*CHANNEL_3);
        Percent_burden_Channel_1_3 =(Burden_Channel_1_3/Burden_area)*100;
        
        % Percent Burden with Channel 2 and 3
        Burden_Channel_2_3= nnz(BURDEN.*CHANNEL_2.*CHANNEL_3);
        Percent_burden_Channel_2_3 =(Burden_Channel_2_3/Burden_area)*100;
        
        % Percent Burden with Channel 1 and 2 and 3
        Burden_Channel_1_2_3= nnz(BURDEN.*CHANNEL_1.*CHANNEL_2.*CHANNEL_3);
        Percent_burden_Channel_1_2_3 =(Burden_Channel_1_2_3/Burden_area)*100;
                       
        % Create table       
        Results.(strcat(Burden,'_percent_area'))=Percent_burden_area;
        Results.(strcat(Burden,'_with_', Channel_1,'_percent_area'))=Percent_burden_Channel_1;
        Results.(strcat(Burden,'_with_', Channel_2,'_percent_area'))=Percent_burden_Channel_2;
        Results.(strcat(Burden,'_with_', Channel_3,'_percent_area'))=Percent_burden_Channel_3;
        Results.(strcat(Burden,'_with_', Channel_1,'_', Channel_2, '_percent_area'))=Percent_burden_Channel_1_2;
        Results.(strcat(Burden,'_with_', Channel_1,'_', Channel_3, '_percent_area'))=Percent_burden_Channel_1_3;
        Results.(strcat(Burden,'_with_', Channel_2,'_', Channel_3, '_percent_area'))=Percent_burden_Channel_2_3;
        Results.(strcat(Burden,'_with_', Channel_1,'_', Channel_2,'_', Channel_3, '_percent_area'))=Percent_burden_Channel_1_2_3;
        Table1 = struct2table(Results);
        Table1.Case(:)={FileName};   
        Table1 = Table1(:,[9 1 2 3 4 5 6 7 8]);
        Table1_combined =vertcat(Table1,Table1_combined); 
                 
        % Save Excel export                   
        writetable (Table1_combined, (strcat(srcPath,[filesep 'Results_burden' filesep strcat(Burden,'_percent_area.csv')])));
                 
        end  
    end                      
         disp('Done - enjoy! :)')
end

end
    
    
    



