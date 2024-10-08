%% Import data from spreadsheet
% Script for importing data from the following spreadsheet:
%
%    Workbook: C:\Users\urica\Dropbox\TFG_OriolCalsina\Itàlia 14-15\italia1415.xlsx
%    Worksheet: Sheet1
%
% Auto-generated by MATLAB on 19-Jul-2024 19:29:47

%% Set up the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 7);

% Specify sheet and range
opts.Sheet = "Sheet1";
opts.DataRange = "A2:G29";

% Specify column names and types
opts.VariableNames = ["WEEK", "CASOSPROCESSATS", "CASOSGRIP", "POSITIVITY", "POSITIVITY1", "casos105HabILI", "GRIP105HAB"];
opts.VariableTypes = ["string", "double", "double", "double", "double", "double", "double"];

% Specify variable properties
opts = setvaropts(opts, "WEEK", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "WEEK", "EmptyFieldRule", "auto");

% Import the data
ital1415 = readtable("C:\Users\urica\Dropbox\TFG_OriolCalsina\Itàlia 14-15\italia1415.xlsx", opts, "UseExcel", false);
Inf=ital1415.GRIP105HAB;
dif2dies=zeros(length(Inf),1);
for z=1:length(Inf)
    if [z+2]<28
    dif2dies(z)=Inf(z+2)-Inf(z);
    end
end
for n=1:z
    if dif2dies(n)>3
        break
    end
end
Inf=Inf(n:end);

%% Clear temporary variables
clear opts