import React from "react"


class Tabs extends React.Component{
  constructor(props){
    super(props);
    this.state = {index: 0}

  // {key: value}
  // const name = {title: content}
  
  }


  render(){

    const tabs = this.props.arr.map( (obj)  => obj.title)
    const content = this.props.arr.map((obj) => obj.content)

    const tabsElements = tabs.map((title, idx)=> 
      <div className="tabbox"><h1 key={idx} onClick={() => { this.setState({ index: idx }) }}>{title}</h1></div>)


    return (
        <div>
            <h1>Tabs</h1><br/>
            <div className="tabheader">
            <ul className="header">{tabsElements}</ul>
            <div className="tabcontent">
            <article> {this.props.arr[this.state.index].content}</article>
            </div>
            </div>
        </div>
    )

  }

}


export default Tabs