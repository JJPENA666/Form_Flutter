import 'package:flutter/material.dart';

class FormularioPage extends StatefulWidget {
  const FormularioPage({Key? key}) : super(key: key);

  @override
  _FormularioPageState createState() => _FormularioPageState();
}


class _FormularioPageState extends State<FormularioPage> {
  String _nombre = '';
  String _email = '';
  String _password = '';

  List<String> _optTipoPaciente = ['Crónico', 'Terminal', 'Observación'];
  String _valorEscojidoTipoPaciente = 'Crónico';

  bool _checkEnfermedadTerminal = false;
  double _sliderValor = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Formulario'),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 10.0),
          children: [
            _crearInput(),    // TextField con múltiples opciones de decoración
            Divider(),
            _crearEmail(),
            Divider(),
            _crearPassword(),
            Divider(),
            _crearDropDown(),
            Divider(),
            _crearCheckBox(),
            Divider(),
            _crearSlider(),
            
            Divider(),
            Divider(),
            _visualizarDatos(),

          ],
        ));
  }

  Widget _visualizarDatos(){
    return Column(
      children: [
        Text('Nombre del paciente: $_nombre'),
        Text('Email del paciente: $_email'),
        Text('Password: $_password'),
        Text('Tipo de paciente: $_valorEscojidoTipoPaciente'),
        Text('Enfermedad terminal: $_checkEnfermedadTerminal'),
        Text('Meses hospitalizado: ${_sliderValor.toInt()}'),

      ],
    );
  }
  
  Widget _crearSlider(){
    
    return Row(
      children: [
        Expanded(
          child: Slider(
              value: _sliderValor,
              onChanged: (nuevoValor){ setState(() {
                _sliderValor = (nuevoValor.toInt()).toDouble();
              }); },
            label: 'Número de meses hospitalizado:',
            divisions: 24,
            min: 1,
            max:24
          ),
        )
      ],
    );
    
  }
  
  Widget _crearCheckBox(){
    return CheckboxListTile(
        title: Text('Enfermedad terminal'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),side: BorderSide(color: Colors.grey)),
        value: _checkEnfermedadTerminal,
        onChanged: (nuevoValor) {   // Hay que llamar a setState para que redibuje el CheckBox
          setState(() { _checkEnfermedadTerminal = nuevoValor! ;});
        }

    );
  }
  Widget _crearDropDown(){
    return Container(
      height: 60.0,
      padding: EdgeInsets.only(left: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: Colors.grey
        )
      ),
      child: Row(
        children: [
          DropdownButton(
            value: _valorEscojidoTipoPaciente,
            onChanged: (String? valor) { setState(() { _valorEscojidoTipoPaciente = valor!; });},
            items: _crearItemsDropDown(),

          ),
          Spacer(),
          Container(child: Icon(Icons.api),
                    padding: EdgeInsets.only(right: 10.0),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _crearItemsDropDown(){

    List<DropdownMenuItem<String>> lista = [];
    _optTipoPaciente.forEach((element) {
       lista.add(DropdownMenuItem(child: Text('$element'),value: element,));
    });

    return lista;
  }

  Widget _crearEmail(){

    return TextField(
      onChanged: (valor) => setState((){
                                        _email = valor;
                                        print(valor);}
                                    ),   // Fijarse que podemos guardar una cadena vacía
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email del paciente',
        labelText: 'Email',
        suffixIcon: Icon(Icons.email),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        )
      ),
    );
  }


  Widget _crearPassword(){

    return TextField(
      onChanged: (valor) => setState((){_password = valor;}),   // Fijarse que podemos guardar una cadena vacía
      obscureText: true,
      obscuringCharacter: '-',
      maxLength: 20,
      decoration: InputDecoration(
          hintText: 'Password de entrada',
          labelText: 'Password',
          suffixIcon: Icon(Icons.password),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          )
      ),
    );
  }

  Widget _crearInput() {

    return TextField(
      onChanged: (valor) => setState((){_nombre = valor;}),   // Fijarse que podemos guardar una cadena vacía
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        border: OutlineInputBorder(     // Establece un borde cicular/otro  alrededor de la caja de texto
          borderRadius: BorderRadius.circular(15.0),
        ),
        counterText: 'Número de caracteres: ${_nombre.length}',   // Texto que aparece a la derecha y debajo de la caja
        hintText: 'Nombre del paciente',          // Texto que aparece dentro de la caja y desaparece al escribir
        labelText: 'Nombre',                      // Texto qye aparece encima de la caja AL PULSAR EN EL INTERIOR PARA ESCRIBIR
        helperText: 'Introduce el nombre del paciente',  // Texto que aparece a la izquierda y abajo de la caja
            // Widget que aparece a la derecha dentro de la caja
        icon: Icon(Icons.accessibility),          // Widget que aparece a la izquierda fuera de la caja

      ),
    );

  }

}