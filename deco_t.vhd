library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity deco_t is
    Port (
        Clock : in STD_LOGIC;               -- Se�al de reloj
        Done : in STD_LOGIC;                -- Se�al Done
        w : in STD_LOGIC;                   -- Se�al de inicio
        T0, T1, T2, T3 : out STD_LOGIC      -- Salidas decodificadas
    );
end deco_t;

architecture Behavioral of deco_t is
    signal Counter : STD_LOGIC_VECTOR (1 downto 0) := "00"; -- Contador de 2 bits
    signal Clear : STD_LOGIC;                               -- Se�al Clear
begin

    -- L�gica para Clear
    Clear <= ((not w) and T0) or Done;

    -- Proceso para incrementar el contador con Clear y Reloj
    process (Clock, Clear)
    begin
        if Clear = '1' then
            Counter <= "00"; -- Reinicia el contador
        elsif rising_edge(Clock) then
            Counter <= Counter + 1; -- Incrementa el contador
        end if;
    end process;

    -- Decodificaci�n de las salidas
    T0 <= '1' when Counter = "00" else '0';
    T1 <= '1' when Counter = "01" else '0';
    T2 <= '1' when Counter = "10" else '0';
    T3 <= '1' when Counter = "11" else '0';

end Behavioral;
