%% Import data from spreadsheet
% Script for importing data from the following spreadsheet:
%
%    Workbook: C:\Users\urica\OneDrive\Escriptori\TFG\PaisosFlunet\espanya.xlsx
%    Worksheet: Sheet1
%
% Auto-generated by MATLAB on 09-Mar-2024 17:47:20

%% Set up the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 8);

% Specify sheet and range
opts.Sheet = "Sheet1";
opts.DataRange = "A2:H26";

% Specify column names and types
opts.VariableNames = ["Week", "CasosProcessats", "casosGrip", "Positivity", "Positivity1", "casos105HabARI", "productegrip105HabARI", "mitjanaCorreguda"];
opts.VariableTypes = ["string", "double", "double", "double", "double", "double", "double", "double"];

% Specify variable properties
opts = setvaropts(opts, "Week", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "Week", "EmptyFieldRule", "auto");

% Import the data
esp = readtable("espanya.xlsx", opts, "UseExcel", false);

%% Clear temporary variables
clear opts