library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_with_Registers is
    Port (
        clk       : in  STD_LOGIC;                       -- Señal de reloj
        Rin       : in  STD_LOGIC;                       -- Señal de carga para registro A
        Gin       : in  STD_LOGIC;                       -- Señal de carga para registro G
        Gout      : in  STD_LOGIC;                       -- Señal de salida para registro G
        AddSub    : in  STD_LOGIC;                       -- 0 = Suma, 1 = Resta
        DataBus   : inout STD_LOGIC_VECTOR(3 downto 0);  -- Bus de datos (bidireccional)
        B         : in  STD_LOGIC_VECTOR(3 downto 0)    -- Operando B directo
    );
end ALU_with_Registers;

architecture Behavioral of ALU_with_Registers is
    -- Declaración de registros
    signal A : STD_LOGIC_VECTOR(3 downto 0) := (others => '0'); -- Registro A
    signal G : STD_LOGIC_VECTOR(3 downto 0) := (others => '0'); -- Registro G

    -- Señal interna para el resultado de la ALU
    signal ALU_Result : STD_LOGIC_VECTOR(3 downto 0);
begin
    -- Proceso para el registro A
    process(clk)
    begin
        if rising_edge(clk) then
            if Rin = '1' then
                A <= DataBus;  -- Cargar dato del bus de datos en registro A
            end if;
        end if;
    end process;

    -- Lógica de la ALU
    process(A, B, AddSub)
    begin
        if AddSub = '0' then
            -- Operación de suma
            ALU_Result <= std_logic_vector(unsigned(A) + unsigned(B));
        else
            -- Operación de resta
            ALU_Result <= std_logic_vector(unsigned(A) - unsigned(B));
        end if;
    end process;

    -- Proceso para el registro G
    process(clk)
    begin
        if rising_edge(clk) then
            if Gin = '1' then
                G <= ALU_Result;  -- Cargar el resultado de la ALU en registro G
            end if;
        end if;
    end process;

    -- Salida del registro G al bus de datos
    DataBus <= G when Gout = '1' else (others => 'Z');  -- Alta impedancia si Gout = 0
end Behavioral;
