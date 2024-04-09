function var1 = jsonread(jsonfilename)
fid = fopen(jsonfilename); 
raw = fread(fid,inf); 
str = char(raw'); 
fclose(fid); 
var1 = jsondecode(str);

end

