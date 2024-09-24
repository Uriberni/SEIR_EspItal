%% Import data from spreadsheet
% Script for importing data from the following spreadsheet:
%
%    Workbook: C:\Users\urica\Dropbox\TFG_OriolCalsina\Itàlia 17-18\italia1718.xlsx
%    Worksheet: Sheet1
%
% Auto-generated by MATLAB on 16-Jul-2024 17:28:47

%% Set up the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 7);

% Specify sheet and range
opts.Sheet = "Sheet1";
opts.DataRange = "A2:G25";

% Specify column names and types
opts.VariableNames = ["WEEK", "CASOSPROCESSATS", "CASOSGRIP", "POSITIVITY", "POSITIVITY1", "casos105HabILI", "GRIP105HAB"];
opts.VariableTypes = ["string", "double", "double", "double", "double", "double", "double"];

% Specify variable properties
opts = setvaropts(opts, "WEEK", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "WEEK", "EmptyFieldRule", "auto");

% Import the data
ital1718 = readtable("C:\Users\urica\Dropbox\TFG_OriolCalsina\Itàlia 17-18\Injecció_S\italia1718.xlsx", opts, "UseExcel", false);
Inf=ital1718.GRIP105HAB;
a=0.5*ones(1,1);
Inf=[a;Inf];

%% Clear temporary variables
clear opts