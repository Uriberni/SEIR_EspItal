%% Import data from spreadsheet
% Script for importing data from the following spreadsheet:
%
%    Workbook: C:\Users\urica\Dropbox\TFG_OriolCalsina\Espanya17-18\espanya1718.xlsx
%    Worksheet: Sheet1
%
% Auto-generated by MATLAB on 24-Apr-2024 18:07:07

%% Set up the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 7);

% Specify sheet and range
opts.Sheet = "Sheet1";
opts.DataRange = "A2:G31";

% Specify column names and types
opts.VariableNames = ["Week", "CasosProcessats", "casosGrip", "Positivity", "Positivity1", "casos105HabILI", "productegrip105HabILI"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double"];

% Import the data
esp1718 = readtable("C:\Users\urica\Dropbox\TFG_OriolCalsina\Espanya17-18\Injecció_S\espanya1718.xlsx", opts, "UseExcel", false);
Inf=esp1718.productegrip105HabILI;

dif2dies=zeros(length(Inf),1);
for z=1:length(Inf)
    if [z+2]<30
    dif2dies(z)=Inf(z+2)-Inf(z);
    end
end
for n=1:z
    if dif2dies(n)>0.30
        break
    end
end
Inf=Inf(n:end);

%% Clear temporary variables
clear opts