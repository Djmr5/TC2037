import re

regex = r'(?xi) ( [+-]? (?: \d+ [.] \d*) (?: [eE] [+-]? \d+ )? ) | ( [-]? \d+ ) | ( // .* ) | ( [a-z] \w* ) | ( [=] ) | ( [+] ) | ( [-] ) | ( [*] ) | ( [/] ) | ( \^ ) | ( [(] ) | ( [)] ) | ( \s ) | ( . )'
labels = ['Real', 'Real', 'Entero', 'Comentario', 'Variable', 'Asignación', 'Suma', 'Resta', 'Multiplicación', 'División', 'Potencia', 'Paréntesis que abre', 'Paréntesis que cierra', 'Espacios', 'Expresión inválida']
valid = []
invalid = []

with open('operaciones.txt', 'r') as file:
    for line in file:
        if line:
            comment = re.search(r"//.*", line)
            if comment:
                comment = comment.group()
            else:
                comment = ""
            line = re.sub(r"\s+", "", line)
            valid_line = []
            invalid_line = []
            for match in re.finditer(regex, line):
                for group_idx, group in enumerate(match.groups(), start=1):
                    if group and group_idx == 14:
                        invalid_line.append(f"{labels[group_idx]}: {group}")
                    elif group and group_idx != 13:
                        if group_idx == 3:
                            valid_line.append(f"{labels[group_idx]}: {comment}")
                        else:
                            valid_line.append(f"{labels[group_idx]}: {group}")
            if invalid_line or valid_line:
                invalid.append(invalid_line)
                valid.append(valid_line)

print("--------------------------------------------------\n              Comienza Reconocimento\n--------------------------------------------------")
for j in range(len(valid)):
    if invalid[j]:
        print('Invalid lines:\n' + '\n'.join(invalid[j]))
    elif valid[j]:
        print('\n'.join(valid[j]))
    else:
        print('Vacío')
    if j != len(valid) - 1:
        print("--------------------------------------------------\n                 Siguiente Linea\n--------------------------------------------------")
print("--------------------------------------------------\n               Acaba Reconocimiento\n--------------------------------------------------")

# Double = isnt valid
# if double + or - then break
# error en 6.1E--8 ñp detecta separado y lo de bien
# no se puede operacion igual a variable
# no se puede operacion igual a operacion