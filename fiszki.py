import random
dictionary = {'arbuz': 'watermelon', 'gruszka': 'pear', 'jabłko': 'apple', 'ananas': 'pineapple', 'brzoskwinia': 'peach'}

print('Program jest odpowiednikiem fiszek z języka angielskiego. Jeśli chcesz zakończyć program, zamiast odpowiedzi wpisz "koniec" albo "end"')
print('')

while 1==1:
    key = random.choice(list(dictionary.keys()))
    print('jak po angielsku nazywa się "' + key + '"?')
    answer = input() 
    if answer == "koniec" or answer == "end": break
    elif dictionary[key] == answer: print('Brawo! "' + key + '" to po angielsku "' + answer + '"')
    else: print('Blisko - "' + key + '" to po angielsku ' + dictionary[key] + '"')
