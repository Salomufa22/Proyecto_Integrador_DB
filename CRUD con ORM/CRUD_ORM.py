from tortoise import Tortoise, fields, run_async
from tortoise.models import Model

async def main():
    await Tortoise.init(
        db_url='postgres://postgres:0906@localhost:5432/Proyecto_Integrador_DB',
        modules={'models': ['__main__']},
    )
    await Tortoise.generate_schemas()
    #await bulk_insert_data()
    await execute()

class Categoria(Model):
    id_categoria = fields.IntField(pk=True)
    nombre = fields.CharField(max_length=255)

class Producto(Model):
    id_producto = fields.IntField(pk=True)
    nombre = fields.CharField(max_length=255)
    marca = fields.CharField(max_length=255)
    categoria = fields.ForeignKeyField("models.Categoria", related_name="producto_categoria")
    precio_unitario = fields.DecimalField(max_digits=10, decimal_places=2)
    
class Sucursal(Model):
    id_sucursal = fields.IntField(pk=True)
    nombre = fields.CharField(max_length=255)
    direccion = fields.CharField(max_length=255)
class Stock(Model):
    id_stock = fields.IntField(pk=True)
    sucursal = fields.ForeignKeyField("models.Sucursal", related_name="stock_sucursal")
    producto = fields.ForeignKeyField("models.Producto", related_name="stock_producto")
    cantidad = fields.DecimalField(max_digits=10, decimal_places=2)
    unique_together = (("sucursal_id", "producto_id"),)

class Cliente(Model):
    id_cliente = fields.IntField(pk=True)
    nombre = fields.CharField(max_length=255)
    telefono = fields.CharField(max_length=255)

class Orden(Model):
    id_orden = fields.IntField(pk=True)
    cliente = fields.ForeignKeyField("models.Cliente", related_name="Cliente")
    sucursal = fields.ForeignKeyField("models.Sucursal", related_name="Sucursal")
    fecha = fields.DateField()
    total = fields.DecimalField(max_digits=10, decimal_places=2)

class Item(Model):
    id_item = fields.IntField(pk=True)
    orden = fields.ForeignKeyField("models.Orden", related_name="Orden")
    producto = fields.ForeignKeyField("models.Producto", related_name="Producto")
    cantidad = fields.DecimalField(max_digits=10, decimal_places=2)
    monto_venta = fields.DecimalField(max_digits=10, decimal_places=2)



async def execute():
    while True:
        preguntaTabla = """Dígita el número de la tabla con la que deseas interactuar:
1 -> Categoria
2 -> Producto
3 -> Sucursal
4 -> Stock
5 -> Cliente
6 -> Orden
7 -> Item
"""
        tabla = input(preguntaTabla)
        if tabla == "1":
            selectTabla = Categoria
            print("\nTabla Seleccionada: " + selectTabla.__name__ + "\n")
        elif tabla == "2":
            selectTabla = Producto
            print("\nTabla Seleccionada: " + selectTabla.__name__ + "\n")
        elif tabla == "3":
            selectTabla = Sucursal
            print("\nTabla Seleccionada: " + selectTabla.__name__ + "\n")
        elif tabla == "4":
            selectTabla = Stock
            print("\nTabla Seleccionada: " + selectTabla.__name__ + "\n")
        elif tabla == "5":
            selectTabla = Cliente
            print("\nTabla Seleccionada: " + selectTabla.__name__ + "\n")
        elif tabla == "6":
            selectTabla = Orden
            print("\nTabla Seleccionada: " + selectTabla.__name__ + "\n")
        elif tabla == "7":
            selectTabla = Item
            print("\nTabla Seleccionada: " + selectTabla.__name__ )
        else:
            print("\nEntrada no válida, digite otra opción:")

        preguntaOperacion = """Dígita el número de la operación que desea hacer:
1 -> Crear
2 -> Listar
3 -> Obtener
4 -> Eliminar
"""
        entrada = input(preguntaOperacion)
        if entrada == "1":
            await crearEnTabla(selectTabla)
        elif entrada == "2":
            await listarTabla(selectTabla)
        elif entrada == "3":
            idBuscar = input("Digite la fila a obtener por su Identificador:\n")
            await obtenerEnTabla(selectTabla, int(idBuscar))
        elif entrada == "4":
            idBuscar = input("Digite la fila a borrar por su Identificador:\n")
            await borrarEnTabla(selectTabla, int(idBuscar))
        else: 
            print("Opción no existente")

async def crearEnTabla(selectTabla):
    columnas = selectTabla._meta.fields_map.keys()
    valores = {}

    for columna in columnas:
        valor = input(f"Ingrese el valor para la columna '{columna}': ")
        valores[columna] = valor

    try:
        await selectTabla.create(**valores)
        print(f"Se insertaron los datos en la tabla {selectTabla.__name__}")
    except Exception as e:
        print(f"Error al insertar datos en la tabla {selectTabla.__name__}: {str(e)}")

    print("\n------------------------------------------------------------------------------\n")

async def listarTabla(selectTabla):
    datos = await selectTabla.all()
    if datos:
        print(f"\nListado de registros en la tabla {selectTabla.__name__}:")
        for dato in datos:
            print(dato.__dict__)
    else:
        print(f"\nNo hay registros en la tabla {selectTabla.__name__}")
    
    print("\n------------------------------------------------------------------------------\n")
    
    

async def obtenerEnTabla(selectTabla, idBuscar):
    """filtro = {"id_" + selectTabla.__name__.lower(): idBuscar}

    # Buscar el registro por ID
    registro = await selectTabla.filter(**filtro).first()
    print(registro.__dict__)
    print(registro)"""
    datos = await selectTabla.all()
    for dato in datos:

        if dato.__dict__["id_" + selectTabla.__name__.lower()] == idBuscar: #
            print()
            print(dato.__dict__)
        else:
            print(f"No hay registros del ID {idBuscar} en la tabla {selectTabla.__name__}")

    print("\n------------------------------------------------------------------------------\n")

async def borrarEnTabla(selectTabla, idBuscar):
    datos = await selectTabla.all()
    for dato in datos:

        try:
            if dato.__dict__["id_" + selectTabla.__name__.lower()] == idBuscar: #
                temp = dato.__dict__

                await dato.delete()

                print("\nFila ")
                print(temp)
                print("Eliminada correctamente!")
                break

            else:
                print(f"\nNo hay registros del ID {idBuscar} en la tabla {selectTabla.__name__}")

        except:
            print("\nNo puedes borrar este dato, pues existen dependencias que lo impiden!")
    

    print("\n------------------------------------------------------------------------------\n")

run_async(main())