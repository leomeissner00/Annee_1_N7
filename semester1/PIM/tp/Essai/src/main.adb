with Ada.Text_IO;    use Ada.Text_IO;
with Ada.Command_Line;   use Ada.Command_Line;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Bounded; use Ada.Strings.Bounded;
with Ada.Streams.Stream_IO;    use Ada.Streams.Stream_IO;

procedure Main is



        type T_Octet is mod 2 ** 8;	-- sur 8 bits
        for T_Octet'Size use 8;

        Argument_Exception : Exception;
        Fichier_non_hff_Exception : Exception;



        File_Name : Standard.String ;
        File      : Ada.Streams.Stream_IO.File_Type;	-- car il y a aussi Ada.Text_IO.File_Type
        S         : Stream_Access;
        Octet     : T_Octet;
        File_case : Standard.String;
begin
        --Vérifier qu'il n'y a pas d'argument en plus dans la ligne de commande
        if Argument_Count /= 1 then
                raise Argument_Exception;
        end if;

        --Vérifier que le fichier est bien un .hff
        File_Name := Argument(1);
        File_case :=Slice(To_Unbounded_String(File_name), Length(File_Name)-3, Length(File_Name));

        if File_case /= ".hff" then
                raise Fichier_non_hff_Exception;
        end if;

end Main;
