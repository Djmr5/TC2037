import re
import os

# Regex
regex = r"(?xi) ( \d+\.?\d*[eE][+-]{2,}\d+ ) | ( [+-]? (?: \d+ [.] \d*) (?: [eE] [+-]? \d+ )? ) | ( [-]? \d+ ) | ( // .* ) | ( [a-z] \w* ) | ( [=] ) | ( [+] ) | ( [-] ) | ( [*] ) | ( [/] ) | ( \^ ) | ( [(] ) | ( [)] ) | ( \s ) | ( . )"
labels = [
    "Expresión inválida",
    "Real",
    "Entero",
    "Comentario",
    "Variable",
    "Asignación",
    "Suma",
    "Resta",
    "Multiplicación",
    "División",
    "Potencia",
    "Paréntesis que abre",
    "Paréntesis que cierra",
    "Espacios",
    "Expresión inválida en",
]
invalid_expression_i = [0, 14]
operator_expression_i = [6, 7, 8, 10]
# Lists
valid = []
invalid = []
# Flags
operator = False
first_var = False
second_equal = False
index = 0
# Variables
documento = input("Nombre del documento a analizar: ")


def file_exists(filename):
    for file in os.listdir("."):
        if file == filename:
            return True
    return False


if not (file_exists(documento)):
    print("File not found, enter a valid name")
else:
    with open(documento, "r") as file:
        for line in file:
            if line:
                # Store comment
                comment = re.search(r"//.*", line)
                if comment:
                    comment = comment.group()
                else:
                    comment = ""
                # Remove spaces
                line = re.sub(r"\s+", "", line)
                valid_line = []
                invalid_line = []
                for match in re.finditer(regex, line):
                    for group_idx, group in enumerate(match.groups(), start=0):
                        if group and group_idx in invalid_expression_i:
                            invalid_line.append(f"{labels[group_idx]}: {group}")
                            index += 1
                        elif group and group_idx != 13:
                            if group_idx == 4 and index == 0:
                                valid_line.append(f"{labels[group_idx]}: {group}")
                                index += 1
                                first_var = True
                            # =
                            elif group_idx == 5:
                                if index == 1:
                                    if first_var == True:
                                        valid_line.append(
                                            f"{labels[group_idx]}: {group}"
                                        )
                                        index += 1
                                    else:
                                        invalid_line.append(
                                            f"Expresión inválida en: {group}"
                                        )
                                        index += 1
                                else:
                                    invalid_line.append(
                                        f"Expresión inválida en: {group}"
                                    )
                                    index += 1
                            elif group_idx == 3:
                                operator = False
                                valid_line.append(f"{labels[group_idx]}: {comment}")
                                index += 1
                            elif group_idx in operator_expression_i:
                                if operator:
                                    invalid_line.append(
                                        f"Expresión inválida operador en: {group}"
                                    )
                                    index += 1
                                else:
                                    valid_line.append(f"{labels[group_idx]}: {group}")
                                    index += 1
                                operator = True
                            else:
                                operator = False
                                valid_line.append(f"{labels[group_idx]}: {group}")
                                index += 1
                first_var = False
                index = 0
                if invalid_line or valid_line:
                    invalid.append(invalid_line)
                    valid.append(valid_line)

    print(
        "--------------------------------------------------\n              Comienza Reconocimento\n--------------------------------------------------"
    )
    for j in range(len(valid)):
        if invalid[j]:
            print("Expresiones inválidas:\n" + "\n".join(invalid[j]))
        elif valid[j]:
            print("\n".join(valid[j]))
        else:
            print("Vacío")
        if j != len(valid) - 1:
            print(
                "--------------------------------------------------\n                 Siguiente Linea\n--------------------------------------------------"
            )
    print(
        "--------------------------------------------------\n               Acaba Reconocimiento\n--------------------------------------------------"
    )
