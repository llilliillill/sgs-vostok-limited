import './types.ts'
import { defineStore } from 'pinia'
import { ref } from 'vue'

export const useMainStore = defineStore('MainStore', () => {

    const select_city = ref<number>(0)
    const select_workshop = ref<number>(0)
    const select_employee = ref<number>(0)
    const select_brigade = ref<string>('Бригада')
    const select_workshift = ref<string>('Смена')
    
    const city = ref<Option[]>([
        { id: 0, name: 'Город' },
        { id: 1, name: 'Москва' },
        { id: 2, name: 'Санкт-Петербург' },
        { id: 3, name: 'Самара' },
        { id: 4, name: 'Екатеринбург' },
        { id: 5, name: 'Ростов-на-Дону' }
    ])

    const workshop = ref<Option[]>([
        { id: 0, name: 'Цех' },
        { id: 1, name: 'Сталелитейный цех', link: 1 },
        { id: 2, name: 'Сборочный цех', link: 1 },
        { id: 3, name: 'Покрасочный цех', link: 2 },
        { id: 4, name: 'Машиностроительный цех', link: 2 },
        { id: 5, name: 'Станкостроительный цех', link: 3 },
        { id: 6, name: 'Сверлильный цех', link: 3 },
        { id: 7, name: 'Пилильный цех', link: 4 },
        { id: 8, name: 'Пивной цех', link: 4 },
        { id: 9, name: 'Танкостроительный цех', link: 5 },
        { id: 10, name: 'Самолетостроительный цех', link: 5 }
    ])

    const employee = ref<Option[]>([
        { id: 0, name: 'Сотрудник' },
        { id: 1, name: 'Иванов Иван Иванович', link: 1 },
        { id: 2, name: 'Петров Петр Петрович', link: 2 },
        { id: 3, name: 'Воробьев Стас Максимович', link: 2 },
        { id: 4, name: 'Семенов Александр Федорович', link: 3 },
        { id: 5, name: 'Соколов Владимир Иванович', link: 3 },
        { id: 6, name: 'Павлов Олег Юрьевич', link: 3 },
        { id: 7, name: 'Михалков Михаил Михалыч', link: 4 },
        { id: 8, name: 'Ковалев Никита Петрович', link: 5 },
        { id: 9, name: 'Сорокин Матвей Степанович', link: 5 },
        { id: 10, name: 'Мамедов Виктор Петрович', link: 5 },
        { id: 11, name: 'Королев Александр Иванович', link: 6 },
        { id: 12, name: 'Панкратов Григорий Никитович', link: 6 },
        { id: 13, name: 'Васельков Марат Игоревич', link: 7 },
        { id: 14, name: 'Бублик Глеб Петрович', link: 7 },
        { id: 14, name: 'Пупкин Людовик Четвертый', link: 8 },
        { id: 15, name: 'Семёнов Генадий Федорович', link: 8 },
        { id: 16, name: 'Мамкин Данил Иванович', link: 9 },
        { id: 17, name: 'Сеченов Антон Юрьевич', link: 10 }
    ])

    const sort = (array: Option[], value: number) => {
        const result: Option[] = []
        for (let i=0; i<array.length; i++) {
            if (value > 0) {
                if (array[i].link == value || array[i].id == 0) {
                    result.push({
                        id: array[i].id,
                        name: array[i].name,
                        link: array[i].link
                    })
                }
            } else {
                result.push({
                    id: array[i].id,
                    name: array[i].name,
                    link: array[i].link
                })
            }
        }
        return result
    }

    const getSelectValueById = (array: Option[], id: number) => {
        return array.filter(item => item.id == id)[0].name
    }

    /* Сохранить cookies */
    const saveCookies = () => {
        const obj: Result = {}

        if (select_city.value != 0)
            obj.city = getSelectValueById(city.value, select_city.value);

        if (select_workshop.value != 0) 
            obj.workshop = getSelectValueById(workshop.value, select_workshop.value);

        if (select_employee.value != 0)
            obj.employee = getSelectValueById(employee.value, select_employee.value);

        if (select_brigade.value != 'Бригада')
            obj.brigade = select_brigade.value;

        if (select_workshift.value != 'Смена')
            obj.workshift = select_workshift.value;

        /* Сохранить cookies */
        document.cookie = `filter=${ JSON.stringify(obj) }; path=/; expires=30`
    }
    
    return {
        sort,
        city,
        workshop,
        employee,
        select_city,
        select_workshop,
        select_employee,
        select_brigade,
        select_workshift,
        saveCookies
    }
})