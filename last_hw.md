

Найдите полный хеш и комментарий коммита, хеш которого начинается на aefea.

	git show aefea --pretty='%H - %s' -s

	aefead2207ef7e2aa5dc81a34aedf0cad4c32545 - Update CHANGELOG.md
	
Какому тегу соответствует коммит 85024d3?

	git tag --points-at 85024d3

	v0.12.23
	
	
Сколько родителей у коммита b8d720? Напишите их хеши.

	$ git show b8d720 -s  --pretty=%P

	56cd7859e05c36c06b56d013b55a252d0bb7e158 9ea88f22fc6269854151c571162c5bcf958bee2b
	
Перечислите хеши и комментарии всех коммитов которые были сделаны между тегами v0.12.23 и v0.12.24.

    git log v0.12.23..v0.12.24 --oneline
	git log $(git rev-list -n 1 v0.12.23)..$(git rev-list -n 1 v0.12.24) --oneline
	
Найдите коммит в котором была создана функция func providerSource, ее определение в коде выглядит так func providerSource(...) (вместо троеточего перечислены аргументы).

	git log -S 'func providerSource' -p
	
Найдите все коммиты в которых была изменена функция globalPluginDirs.

	git log -S 'func globalPluginDirs' --oneline
	
Кто автор функции synchronizedWriters?

	git log -S 'func synchronizedWriters' -p --pretty='%P - %an' -  В одном из коммитов увидем добавление функции.