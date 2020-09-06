% Dillution Factor Asking
%% Dillution Factor Loading
qst1=['Dillution Factor Matrix ',num2str(DataSetNo),' coulmns?'];
qst2=['Dillution Factor matrix ',num2str(DataSetNo),' Columns and 1 Row exist?'];
DillutionExitFlag=0;
while ~DillutionExitFlag
answer2=questdlg(qst1,qst2,'No: Entering Dillution data now','Yes: Providing name of Matrix','Yes: Providing name of Matrix');
if strcmp(answer2,'No: Entering Dillution data now')
    EnteredDF=ones(1,DataSetNo);
    disp('Lets Enter Dillution Factor for each data');
    disp('You should enter 1 for Undilluted samples and DF>1 for Dilluted ones');
    disp('+++++++++++Enter Dillution Factor++++++++++++++')
    for dnn=1:DataSetNo
        qstinp=['Please Enter the Dillution Factor for Dataset No. ',num2str(dnn),'  \n   '];
        exitflag=0;
        while ~exitflag
           EnteredDF(dnn)=input(qstinp);
           if EnteredDF(dnn)>=1
              exitflag=1;
           else
               disp('OxOxO Dillution Factor should be greater than one OxOxO')
           end
        end
    end
    DFMNS66SS=EnteredDF; clear EnteredDF;
elseif strcmp(answer2,'Yes: Providing name of Matrix')
    h=msgbox(['Name of Dillution Factor Matrix: with ',num2str(DataSetNo),' Columns and 1 row?'],'Name Dillution Factor');
    DF_Matrix_Name=input('Enter the VarName of matrix saved \n   ','s');
    eval(['FoundDillutionFactors=',DF_Matrix_Name])
    DFMNS66SS=FoundDillutionFactors; clear FoundDillutionFactors;
    if size(DFMNS66SS,2)~=DataSetNo || size(DFMNS66SS,1)~=1
        error('Dillution Factor Matrix Does not have the correct dimension')
    elseif DFMNS66SS<1
        error('You should enter 1 for Undilluted samples and DF>1 for Dilluted ones')
    end
end
disp('Loaded Dillution factor is:')
fprintf(' %6.4f ',DFMNS66SS);
fprintf('\n')
 
SSSSatisfied=questdlg('Are you satisfied w/ Dillution Factor?','Are you satisfied w/ Dillution Factor?','Yes?','No?','Yes?');
switch SSSSatisfied
    case 'Yes?'
        DillutionExitFlag=1;
    case 'No?'
        disp('Lets load Dillution Factor data again')
end
end

%% OBSELETE
youWanttoseeFL_CODE=0;
if youWanttoseeFL_CODE
    %% Dillution Factor Loading from FL code
qst1=['Dillution Factor Matrix ',num2str(DataSetNo),' coulmns?'];
qst2=['Dillution Factor matrix ',num2str(DataSetNo),' Columns and 1 Row exist?'];
DillutionExitFlag=0;
while ~DillutionExitFlag
answer2=questdlg(qst1,qst2,'No: Entering Dillution data now','Yes: Providing name of Matrix','Yes: Providing name of Matrix');
if strcmp(answer2,'No: Entering Dillution data now')
    EnteredDF=ones(1,DataSetNo);
    disp('Lets Enter Dillution Factor for each data');
    disp('You should enter 1 for Undilluted samples and DF>1 for Dilluted ones');
    disp('+++++++++++Enter Dillution Factor++++++++++++++')
    for dnn=1:DataSetNo
        qstinp=['Please Enter the Dillution Factor for Dataset No. ',num2str(dnn),'  \n   '];
        exitflag=0;
        while ~exitflag
           EnteredDF(dnn)=input(qstinp);
           if EnteredDF(dnn)>=1
              exitflag=1;
           else
               disp('OxOxO Dillution Factor should be greater than one OxOxO')
           end
        end
    end
    DFMNS66SS=EnteredDF; clear EnteredDF;
elseif strcmp(answer2,'Yes: Providing name of Matrix')
    h=msgbox(['Name of Dillution Factor Matrix: with ',num2str(DataSetNo),' Columns and 1 row?'],'Name Dillution Factor');
    DF_Matrix_Name=input('Enter the VarName of matrix saved \n   ','s');
    eval(['FoundDillutionFactors=',DF_Matrix_Name])
    DFMNS66SS=FoundDillutionFactors; clear FoundDillutionFactors;
    if size(DFMNS66SS,2)~=DataSetNo || size(DFMNS66SS,1)~=1
        error('Dillution Factor Matrix Does not have the correct dimension')
    elseif DFMNS66SS<1
        error('You should enter 1 for Undilluted samples and DF>1 for Dilluted ones')
    end
end
disp('Loaded Dillution factor is:')
fprintf(' %6.4f ',DFMNS66SS);
fprintf('\n')
 
SSSSatisfied=questdlg('Are you satisfied w/ Dillution Factor?','Are you satisfied w/ Dillution Factor?','Yes?','No?','Yes?');
switch SSSSatisfied
    case 'Yes?'
        DillutionExitFlag=1;
    case 'No?'
        disp('Lets load Dillution Factor data again')
end
end
end
clear DillutionExitFlag dnn exitflag qst1 qst2 qstinp SSSSatisfied youWanttoseeFL_CODE