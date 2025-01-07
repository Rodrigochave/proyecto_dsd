library ieee;
use ieee.std_logic_1164.all;

entity registro is 
    port(
        D: in std_logic_vector(0 to 3);  -- Entradas de datos
        clk: in std_logic;              -- Reloj
        Q: out std_logic_vector(0 to 3);-- Salidas de datos
        LE: in std_logic;               -- Latch Enable
        OE: in std_logic                -- Output Enable
    );
end registro;

architecture regis of registro is
    signal Q_internal: std_logic_vector(0 to 3); -- Registro interno para los datos
begin
    process (clk) 
    begin
        if rising_edge(clk) then
            if LE = '1' then
                Q_internal <= D;  -- Almacena los datos de entrada en el registro interno
            end if;
        end if;
    end process;

    Q <= Q_internal when OE = '1' else (others => 'Z'); -- Habilita o deshabilita las salidas
end regis;

