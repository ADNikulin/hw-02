![image](https://github.com/user-attachments/assets/c5ba95a1-ef71-4413-89df-acfb5b6a02b5)# 19.2 Облачная инфраструктура. Terraform.  Никулин Александр

# Домашнее задание к занятию «Основы Terraform. Yandex Cloud»

<details>

  <summary>Исходники задания</summary>

  # hw-02
  https://github.com/netology-code/ter-homeworks/blob/main/02/hw-02.md

</details>

### Цели задания

1. Создать свои ресурсы в облаке Yandex Cloud с помощью Terraform.
2. Освоить работу с переменными Terraform.

### Чек-лист готовности к домашнему заданию

<details>

  <summary>Детали</summary>

  1. Зарегистрирован аккаунт в Yandex Cloud. Использован промокод на грант.
  2. Установлен инструмент Yandex CLI.
  3. Исходный код для выполнения задания расположен в директории [**02/src**](https://github.com/netology-code/ter-homeworks/tree/main/02/src).

</details>

### Задание 0

<details>

  <summary>Детали</summary>

  1. Ознакомьтесь с [документацией к security-groups в Yandex Cloud](https://cloud.yandex.ru/docs/vpc/concepts/security-groups?from=int-console-help-center-or-nav). 
  Этот функционал понадобится к следующей лекции.

</details>

### Задание 1

<details>

  <summary>Детали</summary>

  В качестве ответа всегда полностью прикладывайте ваш terraform-код в git.
  Убедитесь что ваша версия **Terraform** ~>1.8.4

  1. Изучите проект. В файле variables.tf объявлены переменные для Yandex provider.
  2. Создайте сервисный аккаунт и ключ. [service_account_key_file](https://terraform-provider.yandexcloud.net).
     > ![image](https://github.com/user-attachments/assets/40e94795-8fd1-4ea1-a2a2-1bffd846b336) \
     > ![image](https://github.com/user-attachments/assets/9fbfbf1d-232a-441c-a61e-eb36a88a1c99) \
     > ![image](https://github.com/user-attachments/assets/d43fa9bb-e983-47ae-a6aa-29038fbed951) \
     > ![image](https://github.com/user-attachments/assets/529b720c-30d2-4e43-b11c-59a8afd06aa1)

  3. Сгенерируйте новый или используйте свой текущий ssh-ключ. Запишите его открытую(public) часть в переменную **vms_ssh_public_root_key**.
     > ![image](https://github.com/user-attachments/assets/4735d157-63bf-4834-84ef-eae382df4be5)
  
  4. Инициализируйте проект, выполните код. Исправьте намеренно допущенные синтаксические ошибки. Ищите внимательно, посимвольно. Ответьте, в чём заключается их суть.
     > ![image](https://github.com/user-attachments/assets/d29fbf00-dca5-4c71-8b8e-da11ff0dcf2a) \
     > https://yandex.cloud/ru/docs/compute/concepts/vm-platforms Нет такой платформы. Использую 3. \
     > ![image](https://github.com/user-attachments/assets/0d7f76e1-cb34-469f-93c3-98efc981da2e) \
     > Забыл про core_fraction, выставил на 20 и пару ядер + 2 гига памяти для 3й версии (https://yandex.cloud/ru/docs/compute/concepts/performance-levels) \
     > создал - ![image](https://github.com/user-attachments/assets/909e2bb4-d72a-4ebe-8736-d170db39e823) \
     > ![image](https://github.com/user-attachments/assets/e7996bde-e30d-47fe-9d90-99d5745eb65f)

  5. Подключитесь к консоли ВМ через ssh и выполните команду ``` curl ifconfig.me```.
  Примечание: К OS ubuntu "out of a box, те из коробки" необходимо подключаться под пользователем ubuntu: ` `  ` "ssh ubuntu@vm_ip_address" `  `  ` . Предварительно убедитесь, что ваш ключ добавлен в ssh-агент: `  `  ` eval $(ssh-agent) && ssh-add `  ` ` Вы познакомитесь с тем как при создании ВМ создать своего пользователя в блоке metadata в следующей лекции.;
     > ![image](https://github.com/user-attachments/assets/f2bad973-d1c5-4dd1-837c-1ad4a1d81b1f)
  6. Ответьте, как в процессе обучения могут пригодиться параметры ```preemptible = true``` и ```core_fraction=5``` в параметрах ВМ.
  В качестве решения приложите:
     > **core_fraction** - ограничения процессорного времени, для разных платформ они свои, так как я использую 3ю версию, то мы выделяем только 20 прцоентов времени \
     > **preemptible** - прерывание, т.е. в принципе машину могут потушить, либо же больше дня она точн оне будет жить \
     > Во всех случаях - экономия ресурсов в плане денег

</details>

### Задание 2

<details>

  <summary>Детали</summary>

  1. Замените все хардкод-**значения** для ресурсов **yandex_compute_image** и **yandex_compute_instance** на **отдельные** переменные. К названиям переменных ВМ добавьте в начало префикс **vm_web_** .  Пример: **vm_web_name**.
  2. Объявите нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их **default** прежними значениями из main.tf. 
  3. Проверьте terraform plan. Изменений быть не должно. 

  > Докинул новые переменные и их дефолтные значения
  > ```
  >   
  > variable "vms_ssh_user" {
  >   type        = string
  >   default     = "ubuntu"
  >   description = "ssh <vms_ssh_user>@any-ip"
  > }
  > 
  > ### vm settings 
  > variable "vm_web_family_os_name" {
  >   type = string
  >   default = "ubuntu-2004-lts"
  >   description = "family os name"
  > }
  > 
  > variable "vm_web_name" {
  >   type = string
  >   default = "netology-develop-platform-web"
  >   description = "vm name name"
  > }
  > 
  > variable "vm_web_platform_settings" {
  >   type = object({
  >     core_count = number
  >     memory_count = number
  >     core_fraction = number
  >     preemptible = bool
  >     platform_id = string
  >   })
  >   default = {
  >     core_count = 2
  >     core_fraction = 20
  >     memory_count = 2
  >     preemptible = true
  >     platform_id = "standard-v3"
  >   }
  >   description = "https://yandex.cloud/ru/docs/compute/concepts/vm-platforms"
  > }
  > ```

  > Применяем план выполнения: \
  > ![image](https://github.com/user-attachments/assets/5446d012-48d0-4ef7-a98d-70f4000fd394)

</details>

### Задание 3

<details>

  <summary>Детали</summary>

  1. Создайте в корне проекта файл 'vms_platform.tf' . Перенесите в него все переменные первой ВМ.
  2. Скопируйте блок ресурса и создайте с его помощью вторую ВМ в файле main.tf: **"netology-develop-platform-db"** ,  ```cores  = 2, memory = 2, core_fraction = 20```. Объявите её переменные с префиксом **vm_db_** в том же файле ('vms_platform.tf').  ВМ должна работать в зоне "ru-central1-b"
  3. Примените изменения.

  > Новые сеттинги для новой машины.
  > ```
  > ### db vm settings
  > variable "vm_db_platform_settings" {
  >   type = object({
  >     core_count = number
  >     memory_count = number
  >     core_fraction = number
  >     preemptible = bool
  >     platform_id = string
  >   })
  >   default = {
  >     core_count = 2
  >     core_fraction = 20
  >     memory_count = 4
  >     preemptible = true
  >     platform_id = "standard-v3"
  >   }
  >   description = "https://yandex.cloud/ru/docs/compute/concepts/vm-platforms"
  > }
  > 
  > variable "vm_db_name" {
  >   type = string
  >   default = "netology-develop-platform-db"
  >  description = "vm db name name"
  > }
  >   
  > variable "vm_db_nat_is_enable" {
  >   type = bool
  >   default = true
  > }
  > ```

  Так же пришлось развернуть ешё подсеть новую, так что немного переписал базовые переменные: \
  ![image](https://github.com/user-attachments/assets/2ba43714-adf8-4929-8f81-6cd918c8d21e) \
  ![image](https://github.com/user-attachments/assets/ec994fdb-69be-4c1b-8bda-93749fe02c7f) \
  Сделал 2е подсети в разных зонах и виртуальные машины \
  ![image](https://github.com/user-attachments/assets/e01ee17f-a18d-4c55-8a9a-aef5603d8845) \
  ![image](https://github.com/user-attachments/assets/8bb9341f-0bbc-4385-9ec7-a76c57f8c3e4)

</details>

### Задание 4

<details>

  <summary>Детали</summary>

  1. Объявите в файле outputs.tf **один** output , содержащий: instance_name, external_ip, fqdn для каждой из ВМ в удобном лично для вас формате.(без хардкода!!!)
     > ![image](https://github.com/user-attachments/assets/2fa39e3a-3366-458e-b606-a92875707b17)
  3. Примените изменения.
     > ![image](https://github.com/user-attachments/assets/45765ead-e17e-4b84-9a0a-e8fdae037145)
  В качестве решения приложите вывод значений ip-адресов команды ` `  ` terraform output `  ` ` .
    > ![image](https://github.com/user-attachments/assets/4c3e10bd-8052-4179-9fd1-ede654c87478)

</details>

### Задание 5

<details>

  <summary>Детали</summary>

  1. В файле locals.tf опишите в **одном** local-блоке имя каждой ВМ, используйте интерполяцию ${..} с НЕСКОЛЬКИМИ переменными по примеру из лекции.
     > ![image](https://github.com/user-attachments/assets/e6ee884b-c76d-4447-971b-54556fef5605)
  3. Замените переменные внутри ресурса ВМ на созданные вами local-переменные.
     > ![image](https://github.com/user-attachments/assets/578d57eb-8923-402b-91d5-11c9c4023829) \
     > ![image](https://github.com/user-attachments/assets/49bb46f6-caf6-4f69-b007-bc1f33055cc9)
  5. Примените изменения.
     > ![image](https://github.com/user-attachments/assets/96138469-3eb5-4532-8602-4fa7b6e7d2ff)


</details>

### Задание 6

<details>

  <summary>Детали</summary>

  1. Вместо использования трёх переменных  ".._cores",".._memory",".._core_fraction" в блоке  resources {...}, объедините их в единую map-переменную **vms_resources** и  внутри неё конфиги обеих ВМ в виде вложенного map(object).
     
     ```
     vms_resources = {
      web={
        cores=2
        memory=2
        core_fraction=5
        hdd_size=10
        hdd_type="network-hdd"
        ...
      },
      db= {
        cores=2
        memory=4
        core_fraction=20
        hdd_size=10
        hdd_type="network-ssd"
      ...
      }
     }
     ```

     > Собственно я +- сразу так начал делать... \
     > На примере гит измененйи: \
     > ![image](https://github.com/user-attachments/assets/d1227e06-8cfc-402f-b356-e2ace508bd8f) \
     > ![image](https://github.com/user-attachments/assets/927a1745-592c-45d9-a3fa-709d43edd835) \
     > ![image](https://github.com/user-attachments/assets/c7065277-348c-45c1-b0dc-81ba6a377e21) \
     > ![image](https://github.com/user-attachments/assets/af71dbc7-6443-4a28-b6ae-6a04d6aaf057) \
     > ![image](https://github.com/user-attachments/assets/73a4da36-7103-4006-92eb-19de1a11ffc2)

  2. Создайте и используйте отдельную map(object) переменную для блока metadata, она должна быть общая для всех ваших ВМ. 
    ```
    пример из terraform.tfvars:
    metadata = {
      serial-port-enable = 1
      ssh-keys       = "ubuntu:ssh-ed25519 AAAAC..."
    }
    ```  
    > ![image](https://github.com/user-attachments/assets/1f376efb-1bcb-4235-899a-4af76d33f04a)
  
  3. Найдите и закоментируйте все, более не используемые переменные проекта.
  4. Проверьте terraform plan. Изменений быть не должно.
     > ![image](https://github.com/user-attachments/assets/3c75ca16-4bdb-41c6-89d5-0e18c40b3da4)

</details>
------

## Дополнительное задание (со звёздочкой*)

**Настоятельно рекомендуем выполнять все задания со звёздочкой.**   
Они помогут глубже разобраться в материале. Задания со звёздочкой дополнительные, не обязательные к выполнению и никак не повлияют на получение вами зачёта по этому домашнему заданию. 

------

### Задание 7*

<details>
  <summary>Детали</summary>

  Изучите содержимое файла console.tf. Откройте terraform console, выполните следующие задания: 

  1. Напишите, какой командой можно отобразить **второй** элемент списка test_list.
  2. Найдите длину списка test_list с помощью функции length(<имя переменной>).
  3. Напишите, какой командой можно отобразить значение ключа admin из map test_map.
  4. Напишите interpolation-выражение, результатом которого будет: "John is admin for production server based on OS ubuntu-20-04 with X vcpu, Y ram and Z virtual disks", используйте данные из переменных test_list, test_map, servers и функцию length() для подстановки значений.

  **Примечание**: если не догадаетесь как вычленить слово "admin", погуглите: "terraform get keys of map"

  В качестве решения предоставьте необходимые команды и их вывод.

</details>

------

### Задание 8*

<details>
  <summary>Детали</summary>

  1. Напишите и проверьте переменную test и полное описание ее type в соответствии со значением из terraform.tfvars:
  ```

  test = [
  {

    "dev1" = [
    "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117", 
    "10.0.1.7", 
    ]

  }, 
  {

    "dev2" = [
    "ssh -o 'StrictHostKeyChecking=no' ubuntu@84.252.140.88", 
    "10.0.2.29", 
    ]

  }, 
  {

    "prod1" = [
    "ssh -o 'StrictHostKeyChecking=no' ubuntu@51.250.2.101", 
    "10.0.1.30", 
    ]

  }, 
  ]
  
  ```
  2. Напишите выражение в terraform console, которое позволит вычленить строку "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117" из этой переменной.

</details>

### Задание 9*

<details>
  <summary>Детали</summary>

  Используя инструкцию https://cloud.yandex.ru/ru/docs/vpc/operations/create-nat-gateway#tf_1, настройте для ваших ВМ nat_gateway. Для проверки уберите внешний IP адрес (nat=false) у ваших ВМ и проверьте доступ в интернет с ВМ, подключившись к ней через serial console. Для подключения предварительно через ssh измените пароль пользователя: ```sudo passwd ubuntu```

</details>
