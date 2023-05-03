import re

regex = r'(?xi) ( [+-]? (?: \d+ [.] \d* | \d* [.] \d+ ) (?: [eE] [+-]? \d+ )? ) | ( \d+ ) | ( // .* ) | ( [a-z] \w* ) | ( [=] ) | ( [+] ) | ( [-] ) | ( [*] ) | ( [/] ) | ( \^ ) | ( [(] ) | ( [)] ) | ( \s ) | ( . )'
labels = ['Real', 'Real', 'Entero', 'Comentario', 'Variable', 'Asignación', 'Suma', 'Resta', 'Multiplicación', 'División', 'Potencia', 'Paréntesis que abre', 'Paréntesis que cierra', 'Espacios', 'Carácter inválido']
detener = False
text = 'b = 7\na = 32.4\n* (-8.6 - b) / 6.1E-8\nd = ^ b // Esto es un comentario'

for match in re.finditer(regex, text):
    for group_idx, group in enumerate(match.groups(), start=1):
        if group and group_idx == 14:
            print(f"{labels[group_idx]}: {group}\n Se detuvo el programa")
            detener = True
        elif group and group_idx != 13:
            print(f"{labels[group_idx]}: {group}")
    if detener:
        break
