<template>
  <section>
    <!-- Город  -->
    <select 
        id="city" 
        v-model="store.select_city"
    >
        <option 
            v-for="city in store.city" 
            :key="city.id" 
            :value="city.id"
        >
            {{ city.name }}
        </option>
    </select>

    <!-- Цех -->
    <select 
        id="workshop" 
        v-model="store.select_workshop"
    >
        <option 
            v-for="workshop in store.sort(store.workshop, store.select_city)" 
            :key="workshop.id" 
            :value="workshop.id"
        >
            {{ workshop.name }}
        </option>
    </select>

    <!-- Сотрудник -->
    <select 
        id="employee"
        v-model="store.select_employee"
    >
        <option 
            v-for="employee in store.sort(store.employee, store.select_workshop)" 
            :key="employee.id" 
            :value="employee.id"
        >
            {{ employee.name }}
        </option>
    </select>

    <!-- Бригада -->
    <select 
        id="brigade" 
        v-model="store.select_brigade"
    >
      <option value="Бригада">Бригада</option>
      <option value="Первая Бригада">Первая Бригада</option>
      <option value="Вторая Бригада">Вторая Бригада</option>
      <option value="Третья Бригада">Третья Бригада</option>
      <option value="Четвертая Бригада">Четвертая Бригада</option>
      <option value="Пятая Бригада">Пятая Бригада</option>
    </select>

    <!-- Смена -->
    <select 
        id="workshift"
        v-model="store.select_workshift"
    >
      <option value="Смена">Смена</option>
      <option value="Дневнвя">Дневнвя</option>
      <option value="Ночная">Ночная</option>
    </select>

    <button 
        id="save" 
        @click="store.saveCookies()"
    >
        save cookies
    </button>
  </section>
</template>

<script lang="ts" setup>
    import { useMainStore } from '@/stores/MainStore'
    const store = useMainStore()
</script>
