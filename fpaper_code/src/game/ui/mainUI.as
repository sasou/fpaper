/**Created by the Morn,do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class mainUI extends View {
		public var content:Label;
		public var nav:Container;
		public var botBg:Image;
		public var page:TextInput;
		public var totPage:Label;
		public var next:Button;
		public var pre:Button;
		public var zoom:Container;
		public var full:Button;
		public var noFull:Button;
		public var progress:ProgressBar;
		protected var uiXML:XML =
			<View visible="true">
			  <Label x="0" y="-1" width="600" height="400" var="content" align="center"/>
			  <Container bottom="0" var="nav" x="0" centerX="0" y="401" width="600" height="47">
			    <Image url="png.comp.bg" var="botBg" width="600" height="47" x="0" y="0"/>
			    <Label x="297" y="20"/>
			    <Container x="0" y="11" centerX="0">
			      <TextInput text="1" skin="png.comp.textinput" x="81" width="26" height="26" var="page" align="center" autoSize="none" size="15"/>
			      <Label text="/" x="113" size="15"/>
			      <Label text="0" x="125" var="totPage" width="30" height="22" align="left" size="15"/>
			      <Button skin="png.comp.btn_next" x="161" var="next"/>
			      <Button skin="png.comp.btn_pre" var="pre"/>
			    </Container>
			    <Container x="0" y="13" right="4" var="zoom">
			      <Button skin="png.comp.btn_fullScr" var="full"/>
			      <Button skin="png.comp.btn_exitFull" var="noFull" visible="false"/>
			    </Container>
			  </Container>
			  <ProgressBar skin="png.comp.progress" width="212" height="14" value="0" x="194" y="193" var="progress"/>
			</View>;
		public function mainUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}