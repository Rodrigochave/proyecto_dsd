library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity registroFunciones3Deco is
    Port (
        Clock   : in  STD_LOGIC;
        w       : in  STD_LOGIC; -- Señal de habilitación
        T0      : in  STD_LOGIC; -- Temporizador T0
        f1, f0  : in  STD_LOGIC;
        RX1, RX0, RY1, RY0 : in  STD_LOGIC;
        I0, I1, I2, I3 : out STD_LOGIC;
        X0, X1, X2, X3 : out STD_LOGIC;
        Y0, Y1, Y2, Y3 : out STD_LOGIC
    );
end registroFunciones3Deco;

architecture Behavioral of registroFunciones3Deco is

    signal f_reg, RX_reg, RY_reg : STD_LOGIC_VECTOR(1 downto 0);
    signal FR_in : STD_LOGIC; -- Señal interna para la carga del registro

begin

    -- Generación de FR_in
    FR_in <= w AND T0;

    -- Proceso para capturar las entradas en el registro
    process(Clock)
    begin
        if rising_edge(Clock) then
            if FR_in = '1' then
                f_reg  <= f1 & f0;
                RX_reg <= RX1 & RX0;
                RY_reg <= RY1 & RY0;
            end if;
        end if;
    end process;

    -- Decodificadores dos-a-cuatro para las señales de control
    I0 <= not f_reg(1) and not f_reg(0);
    I1 <= not f_reg(1) and f_reg(0);
    I2 <= f_reg(1) and not f_reg(0);
    I3 <= f_reg(1) and f_reg(0);

    X0 <= not RX_reg(1) and not RX_reg(0);
    X1 <= not RX_reg(1) and RX_reg(0);
    X2 <= RX_reg(1) and not RX_reg(0);
    X3 <= RX_reg(1) and RX_reg(0);

    Y0 <= not RY_reg(1) and not RY_reg(0);
    Y1 <= not RY_reg(1) and RY_reg(0);
    Y2 <= RY_reg(1) and not RY_reg(0);
    Y3 <= RY_reg(1) and RY_reg(0);

end Behavioral;
