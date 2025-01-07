library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControladorSenales is
    Port (
        -- Entradas
        T0, T1, T2, T3  : in STD_LOGIC; -- Se�ales de tiempo
        I0, I1, I2, I3  : in STD_LOGIC; -- Se�ales de operaci�n (Load, Move, Add, Sub)
        X0, X1, X2, X3  : in STD_LOGIC; -- Se�ales decodificadas para Rx
        Y0, Y1, Y2, Y3  : in STD_LOGIC; -- Se�ales decodificadas para Ry
        w               : in STD_LOGIC; -- Se�al adicional para Clear
        
        -- Salidas
        Clear    : out STD_LOGIC; -- Inicializaci�n de registros
        Extern   : out STD_LOGIC; -- Se�al para activar buffer externo
        Done     : out STD_LOGIC; -- Indica finalizaci�n de operaci�n
        Ain      : out STD_LOGIC; -- Control del registro A
        Gin      : out STD_LOGIC; -- Control del registro G
        Gout     : out STD_LOGIC; -- Salida del registro G
        AddSub   : out STD_LOGIC; -- Operaci�n suma/resta
        R0in, R1in, R2in, R3in : out STD_LOGIC; -- Control de entrada de registros
        R0out, R1out, R2out, R3out : out STD_LOGIC -- Control de salida de registros
    );
end ControladorSenales;

architecture Behavioral of ControladorSenales is
begin

    -- Generaci�n de la se�al Clear
    Clear <= (NOT w AND T0) OR Done;

    -- Generaci�n de se�ales de control basadas en la tabla
    Extern <= I0 AND T1;

    Done <= (I0 AND T1) OR (I1 AND T1) OR ((I2 OR I3) AND T3);

    Ain <= (I2 OR I3) AND T1;

    Gin <= (I2 OR I3) AND T2;

    Gout <= (I2 OR I3) AND T3;

    AddSub <= I3;

    -- Generaci�n de se�ales Rin en funci�n de la operaci�n y tiempo
    R0in <= ((I0 OR I1) AND T1 AND X0) OR ((I2 OR I3) AND T3 AND X0);
    R1in <= ((I0 OR I1) AND T1 AND X1) OR ((I2 OR I3) AND T3 AND X1);
    R2in <= ((I0 OR I1) AND T1 AND X2) OR ((I2 OR I3) AND T3 AND X2);
    R3in <= ((I0 OR I1) AND T1 AND X3) OR ((I2 OR I3) AND T3 AND X3);

    -- Generaci�n de se�ales Rout en funci�n de la operaci�n y tiempo
    R0out <= ((I1 AND T1 AND Y0) OR (I2 AND (T1 AND X0 OR T2 AND Y0))) OR (I3 AND (T1 AND X0 OR T2 AND Y0));
    R1out <= ((I1 AND T1 AND Y1) OR (I2 AND (T1 AND X1 OR T2 AND Y1))) OR (I3 AND (T1 AND X1 OR T2 AND Y1));
    R2out <= ((I1 AND T1 AND Y2) OR (I2 AND (T1 AND X2 OR T2 AND Y2))) OR (I3 AND (T1 AND X2 OR T2 AND Y2));
    R3out <= ((I1 AND T1 AND Y3) OR (I2 AND (T1 AND X3 OR T2 AND Y3))) OR (I3 AND (T1 AND X3 OR T2 AND Y3));

end Behavioral;