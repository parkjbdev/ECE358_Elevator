<h1><span lang=EN-US>Abstract</span></h1>

<p class=MsoNormal>이번 과제에서는 최대 <span lang=EN-US>2</span>인의 사용자 입력에 대해서 <span
class=SpellE>엘레베이터가</span> 방문해야 할 층을 스케줄링하고<span lang=EN-US>, </span><span
class=SpellE>엘레베이터가</span> 이동하는 로직을 구현해야 한다<span lang=EN-US>. </span>과제에서 주어진 <span
class=SpellE>모듈간의</span> 큰 틀은 다음과 같았다<span lang=EN-US>.</span></p>

<p class=MsoNormal><span lang=EN-US style='mso-no-proof:yes'><!--[if gte vml 1]><v:shapetype
 id="_x0000_t75" coordsize="21600,21600" o:spt="75" o:preferrelative="t"
 path="m@4@5l@4@11@9@11@9@5xe" filled="f" stroked="f">
 <v:stroke joinstyle="miter"/>
 <v:formulas>
  <v:f eqn="if lineDrawn pixelLineWidth 0"/>
  <v:f eqn="sum @0 1 0"/>
  <v:f eqn="sum 0 0 @1"/>
  <v:f eqn="prod @2 1 2"/>
  <v:f eqn="prod @3 21600 pixelWidth"/>
  <v:f eqn="prod @3 21600 pixelHeight"/>
  <v:f eqn="sum @0 0 1"/>
  <v:f eqn="prod @6 1 2"/>
  <v:f eqn="prod @7 21600 pixelWidth"/>
  <v:f eqn="sum @8 21600 0"/>
  <v:f eqn="prod @7 21600 pixelHeight"/>
  <v:f eqn="sum @10 21600 0"/>
 </v:formulas>
 <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
 <o:lock v:ext="edit" aspectratio="t"/>
</v:shapetype><v:shape id="_x0000_i1032" type="#_x0000_t75" alt="텍스트, 스크린샷, 폰트, 라인이(가) 표시된 사진&#10;&#10;자동 생성된 설명"
 style='width:452pt;height:152pt;visibility:visible;mso-wrap-style:square'>
 <v:imagedata src="https://github.com/parkjbdev/verilog_elevator/blob/main/Elevator%20보고서.fld/image001.png" o:title="텍스트, 스크린샷, 폰트, 라인이(가) 표시된 사진&#10;&#10;자동 생성된 설명"
  cropbottom="3760f"/>
</v:shape><![endif]--><![if !vml]><img width=452 height=152
src="https://github.com/parkjbdev/verilog_elevator/blob/main/Elevator%20보고서.fld/image002.png"
alt="텍스트, 스크린샷, 폰트, 라인이(가) 표시된 사진&#10;&#10;자동 생성된 설명" v:shapes="_x0000_i1032"><![endif]></span></p>

<p class=MsoNormal>이를 세부적으로 구현하기 위하여 이와 같은 구조로 실제 모듈들을 설계하였다<span lang=EN-US>.</span></p>

<p class=MsoNormal><span lang=EN-US style='mso-no-proof:yes'><!--[if gte vml 1]><v:shape
 id="_x0000_i1031" type="#_x0000_t75" alt="텍스트, 폰트, 도표, 라인이(가) 표시된 사진&#10;&#10;자동 생성된 설명"
 style='width:451pt;height:148pt;visibility:visible;mso-wrap-style:square'>
 <v:imagedata src="https://github.com/parkjbdev/verilog_elevator/blob/main/Elevator%20보고서.fld/image003.png" o:title="텍스트, 폰트, 도표, 라인이(가) 표시된 사진&#10;&#10;자동 생성된 설명"/>
</v:shape><![endif]--><![if !vml]><img width=451 height=148
src="https://github.com/parkjbdev/verilog_elevator/blob/main/Elevator%20보고서.fld/image003.png"
alt="텍스트, 폰트, 도표, 라인이(가) 표시된 사진&#10;&#10;자동 생성된 설명" v:shapes="_x0000_i1031"><![endif]></span></p>

<p class=MsoNormal><span class=SpellE><span lang=EN-US>Target_Controller</span></span>는
<span class=SpellE>엘레베이터를</span> 목표한 층으로 이동시켜주는 <span lang=EN-US>Controller</span>의
<span lang=EN-US>sub-module</span>이다<span lang=EN-US>. </span>또<span
lang=EN-US>, </span>동일한 <span lang=EN-US>Input</span><span class=SpellE>으로</span>
사용자의 입력을 저장하기 위해서 <span class=SpellE><span lang=EN-US>set_clk</span>를</span> 이용하여
<span class=SpellE><span lang=EN-US>posedge</span></span>가 나타날 때에만 레지스터에 값을 저장하도록
제작하였다<span lang=EN-US>. </span>각각의 층수들은 <span lang=EN-US>3</span>비트 <span
lang=EN-US>unsigned binary</span>로 <span class=SpellE>나타내었다</span><span
lang=EN-US>. </span></p>

<h1><span lang=EN-US>Controller </span>모듈</h1>

<h2><span lang=EN-US>Controller </span>모듈 <span lang=EN-US>State </span>정의</h2>

<p class=MsoNormal>개발의 편의를 위하여 하나의 <span lang=EN-US>state</span>에 대해 두가지 변수를 이용하였으며<span
lang=EN-US>, </span>각각 <span lang=EN-US>done</span>과 <span class=SpellE><span
lang=EN-US>on_board</span></span>이다<span lang=EN-US>. Done</span>은 해당 비트의 사용자가 도착하였는지에
대한 정보이며<span lang=EN-US>, <span class=SpellE>on_board</span></span>는 해당 비트의 사용자가
현재 <span class=SpellE>엘레베이터를</span> 탑승하였는지에 대한 정보이다<span lang=EN-US>. </span>즉 예를
들어<span lang=EN-US>, done=00, <span class=SpellE>on_board</span>=11</span>의 경우 <span
lang=EN-US>2</span>명의 사용자 모두 아직 목적지에 도착하지 못하였으며<span lang=EN-US>, 2</span>명의 사용자
모두 <span class=SpellE>엘레베이터를</span> 탑승하고 있는 상황에 대한 <span lang=EN-US>state</span>이다<span
lang=EN-US>. </span>또 다른 예로 <span lang=EN-US>done=01, <span class=SpellE>on_board</span>=00</span>의
경우 <span lang=EN-US>#2 </span>사용자가 아직 목적지에 도착하지 못하였으며<span lang=EN-US>, </span><span
class=SpellE>엘레베이터에</span> 탑승하지도 못한 <span lang=EN-US>state</span>임을 나타낸다<span
lang=EN-US>. </span>이러한 <span lang=EN-US>notation</span>을 토대로 <span lang=EN-US>state</span><span
class=SpellE>를</span> 구상하면 다음과 같은 <span lang=EN-US>state</span>들이 나올 수 있다<span
lang=EN-US>. </span></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0
 style='border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-yfti-tbllook:1184;mso-padding-alt:0cm 5.4pt 0cm 5.4pt'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>Done</span></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span class=SpellE><span lang=EN-US>On_board</span></span></p>
  </td>
  <td width=469 valign=top style='width:351.8pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal>설명</p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>11</span></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>00</span></p>
  </td>
  <td width=469 valign=top style='width:351.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal>사용자 입력이 없는 경우의 <span lang=EN-US>state</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>10</span></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>00</span></p>
  </td>
  <td width=469 valign=top style='width:351.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>1</span>번 사용자가 아직 탑승하지 않았고 <span
  class=SpellE>엘레베이터를</span> 기다리고 있는 <span lang=EN-US>state </span></p>
  <p class=MsoNormal><span lang=EN-US>+ </span><span class=SpellE>한명의</span> 사용자
  입력을 추가적으로 받을 수 있는 상태</p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:3'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>10</span></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>01</span></p>
  </td>
  <td width=469 valign=top style='width:351.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>1</span>번 사용자가 <span class=SpellE>엘레베이터에</span>
  탑승하여 도착층으로 이동하는 <span lang=EN-US>state</span></p>
  <p class=MsoNormal><span lang=EN-US>+ </span><span class=SpellE>한명의</span> 사용자
  입력을 추가적으로 받을 수 있는 상태</p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:4'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>01</span></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>00</span></p>
  </td>
  <td width=469 valign=top style='width:351.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>2</span>번 사용자가 아직 탑승하지 않았고 <span
  class=SpellE>엘레베이터를</span> 기다리고 있는 <span lang=EN-US>state</span></p>
  <p class=MsoNormal><span lang=EN-US>+ </span><span class=SpellE>한명의</span> 사용자
  입력을 추가적으로 받을 수 있는 상태</p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:5'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>01</span></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>10</span></p>
  </td>
  <td width=469 valign=top style='width:351.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>2</span>번 사용자가 <span class=SpellE>엘레베이터에</span>
  탑승하여 도착층으로 이동하는 <span lang=EN-US>state</span></p>
  <p class=MsoNormal><span lang=EN-US>+ </span><span class=SpellE>한명의</span> 사용자
  입력을 추가적으로 받을 수 있는 상태</p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:6'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>00</span></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>00</span></p>
  </td>
  <td width=469 valign=top style='width:351.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>1</span>번 사용자와 <span lang=EN-US>2</span>번
  사용자가 둘 다 입력을 하였고<span lang=EN-US>, </span>둘 다 <span class=SpellE>엘레베이터를</span>
  탑승하지 못하고 대기중인 <span lang=EN-US>state</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:7'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>00</span></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>01</span></p>
  </td>
  <td width=469 valign=top style='width:351.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>1</span>번 사용자와 <span lang=EN-US>2</span>번
  사용자가 둘 다 입력을 하였고<span lang=EN-US>, 1</span>번 사용자는 <span class=SpellE>엘레베이터에</span>
  탑승하여 자신의 도착층으로 이동중이고<span lang=EN-US>, 2</span>번 사용자는 아직 <span class=SpellE>엘레베이터에</span>
  탑승하지 않고 기다리고 있는 <span lang=EN-US>state</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:8'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>00</span></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>10</span></p>
  </td>
  <td width=469 valign=top style='width:351.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>1</span>번 사용자와 <span lang=EN-US>2</span>번
  사용자가 둘 다 입력을 하였고<span lang=EN-US>, 2</span>번 사용자는 <span class=SpellE>엘레베이터에</span>
  탑승하여 자신의 도착층으로 이동중이고<span lang=EN-US>, 1</span>번 사용자는 아직 <span class=SpellE>엘레베이터에</span>
  탑승하지 않고 기다리고 있는 <span lang=EN-US>state</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:9'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>00</span></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>11</span></p>
  </td>
  <td width=469 valign=top style='width:351.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>1</span>번 사용자와 <span lang=EN-US>2</span>번
  사용자가 둘 다 입력을 하였고<span lang=EN-US>, </span>둘 다 <span class=SpellE>엘레베이터에</span>
  탑승하여 자신의 도착층으로 이동중인 <span lang=EN-US>state</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:10'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><s><span lang=EN-US>11<o:p></o:p></span></s></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><s><span lang=EN-US>01<o:p></o:p></span></s></p>
  </td>
  <td width=469 rowspan=7 valign=top style='width:351.8pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal>탑승한 사용자가 모두 도착층에 도착하였는데 <span class=SpellE>엘레베이터에</span> 탑승하고
  있을 경우는 존재할 수 없다<span lang=EN-US>. </span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:11'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><s><span lang=EN-US>11<o:p></o:p></span></s></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><s><span lang=EN-US>10<o:p></o:p></span></s></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:12'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><s><span lang=EN-US>11<o:p></o:p></span></s></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><s><span lang=EN-US>11<o:p></o:p></span></s></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:13'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><s><span lang=EN-US>10<o:p></o:p></span></s></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><s><span lang=EN-US>10<o:p></o:p></span></s></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:14'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><s><span lang=EN-US>10<o:p></o:p></span></s></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><s><span lang=EN-US>11<o:p></o:p></span></s></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:15'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><s><span lang=EN-US>01<o:p></o:p></span></s></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><s><span lang=EN-US>01<o:p></o:p></span></s></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:16;mso-yfti-lastrow:yes'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><s><span lang=EN-US>01<o:p></o:p></span></s></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><s><span lang=EN-US>11<o:p></o:p></span></s></p>
  </td>
 </tr>
</table>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal>이를 토대로 <span lang=EN-US>State Diagram</span>을 그려보면 다음과 같이 나타낼
수 있다<span lang=EN-US>. </span></p>

<p class=MsoNormal><span lang=EN-US style='mso-no-proof:yes'><!--[if gte vml 1]><v:shape
 id="_x0000_i1030" type="#_x0000_t75" alt="텍스트, 도표, 원, 친필이(가) 표시된 사진&#10;&#10;자동 생성된 설명"
 style='width:452pt;height:356pt;visibility:visible;mso-wrap-style:square'>
 <v:imagedata src="https://github.com/parkjbdev/verilog_elevator/blob/main/Elevator%20보고서.fld/image004.png" o:title="텍스트, 도표, 원, 친필이(가) 표시된 사진&#10;&#10;자동 생성된 설명"/>
</v:shape><![endif]--><![if !vml]><img width=452 height=356
src="https://github.com/parkjbdev/verilog_elevator/blob/main/Elevator%20보고서.fld/image004.png"
alt="텍스트, 도표, 원, 친필이(가) 표시된 사진&#10;&#10;자동 생성된 설명" v:shapes="_x0000_i1030"><![endif]></span></p>

<p class=MsoNormal>위의 <span lang=EN-US>2</span>개의 <span lang=EN-US>bit</span>가 <span
lang=EN-US>done, </span>아래 <span lang=EN-US>2</span>개의 <span lang=EN-US>bit</span>가
<span class=SpellE><span lang=EN-US>on_board</span>를</span> 나타내며<span
lang=EN-US>, transition</span>하는 각각의 조건에 대해서는 색깔로 구분하였다<span lang=EN-US>. </span>또<span
lang=EN-US>, </span>간단하게 표현하기 위해서 사용자가 입력하였을 때 <span lang=EN-US>state</span>이 <span
lang=EN-US>transition</span>하는 것에 대해서는 표기하지 않았으며<span lang=EN-US>, </span>그 외 다른
조건들에 대해서는 자기 자신의 <span lang=EN-US>state</span>을 유지하도록 하였다<span lang=EN-US>. </span>해당
<span lang=EN-US>state transition </span>만을 코드로 간략하게 표기하면 다음과 같다<span
lang=EN-US>.</span></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span lang=EN-US style='mso-no-proof:yes'><!--[if gte vml 1]><v:shape
 id="_x0000_i1029" type="#_x0000_t75" alt="스크린샷, 텍스트이(가) 표시된 사진&#10;&#10;자동 생성된 설명"
 style='width:451pt;height:174pt;visibility:visible;mso-wrap-style:square'>
 <v:imagedata src="https://github.com/parkjbdev/verilog_elevator/blob/main/Elevator%20보고서.fld/image005.png" o:title="스크린샷, 텍스트이(가) 표시된 사진&#10;&#10;자동 생성된 설명"/>
</v:shape><![endif]--><![if !vml]><img width=451 height=174
src="https://github.com/parkjbdev/verilog_elevator/blob/main/Elevator%20보고서.fld/image005.png" alt="스크린샷, 텍스트이(가) 표시된 사진&#10;&#10;자동 생성된 설명"
v:shapes="_x0000_i1029"><![endif]></span></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span lang=EN-US>Controller </span>모듈은 다음과 같이 크게 <span
lang=EN-US>3</span>가지 부분으로 구성된다<span lang=EN-US>.</span></p>

<h2><span class=SpellE>입력단</span></h2>

<p class=MsoNormal>입력단의 경우 최대 <span lang=EN-US>2</span>명의 사용자가 동시에 이용할 수 있으므로<span
lang=EN-US>, </span><span class=SpellE>출발층</span><span lang=EN-US>, </span><span
class=SpellE>도착층</span><span lang=EN-US>, </span>방향 세가지 입력을 받아 이를 저장해두는 역할을 한다<span
lang=EN-US>. State</span><span class=SpellE>를</span> <span class=SpellE>입력받아</span>
저장하기 위해서 <span class=SpellE><span lang=EN-US>set_clk</span></span>라는 <span
class=SpellE>클락을</span> 정의하였으며<span lang=EN-US>, </span>해당 <span lang=EN-US>input</span>에서
<span class=SpellE><span lang=EN-US>posedge</span></span>가 있을 때에 대해서만 유효한 <span
lang=EN-US>input</span><span class=SpellE>으로</span> 간주한다<span lang=EN-US>. <span
class=SpellE>Posedge</span> </span>입력이 들어올 때마다 <span lang=EN-US>input</span>을 받아
저장하는데<span lang=EN-US>, </span>이때 출발층과 도착층이 같거나<span lang=EN-US>, </span>올라가는 입력인데
출발층보다 도착층이 작거나 거꾸로 내려가는 입력인데 출발층이 도착층보다 클 경우에 대해서는 시뮬레이터에 경고 메시지를 발생시키고 해당<span
lang=EN-US> input</span>을 무시하였다<span lang=EN-US>. </span></p>

<p class=MsoNormal>올바른 입력이 들어왔을 때 <span lang=EN-US>done state</span><span
class=SpellE>를</span> 확인하여 만약<span lang=EN-US> 00</span>일 경우<span lang=EN-US>, </span>즉
<span lang=EN-US>2</span>명의 사용자 모두 아직 도착하지 못했을 경우에 대해서는 <span class=SpellE>엘레베이터가</span>
아직 모든 일을 처리하지 못하였기 때문에 경고 메세지를 발생시키고 해당 <span lang=EN-US>Input</span>을 무시하였다<span
lang=EN-US>. </span>만약 <span lang=EN-US>done state</span>의 두 <span
class=SpellE>비트중</span> 어떤 하나라도 <span lang=EN-US>1</span>일 경우 해당하는 레지스터에 사용자의 <span
lang=EN-US>Input</span>을 저장해 두었으며<span lang=EN-US>, done </span>의 두 <span
class=SpellE>비트중</span><span lang=EN-US> 1</span>이였던 비트를 <span lang=EN-US>0</span>으로
바꾸어 해당 동작을 수행해야 하는 상태로 <span lang=EN-US>state transition</span>을 수행하였다<span
lang=EN-US>.</span></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<h2>타겟층 <span class=SpellE>선택단</span> <span lang=EN-US>(output logic)</span></h2>

<p class=MsoNormal>최대 <span lang=EN-US>2</span>명의 사용자에 대해서 출발층과 도착층을 비교하여 현재 이동해야
할 타겟층을 선택하는 역할을 한다<span lang=EN-US>. </span>즉 현재 상태에 대해서 이동해야 할 타겟 층수를 결정하는 단계이다<span
lang=EN-US>. </span>이를 결정하는 방법은 다음의 표와 같다<span lang=EN-US>.</span></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0
 style='border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-yfti-tbllook:1184;mso-padding-alt:0cm 5.4pt 0cm 5.4pt'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>Done</span></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span class=SpellE><span lang=EN-US>On_board</span></span></p>
  </td>
  <td width=469 valign=top style='width:351.8pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal>출력</p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>11</span></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>00</span></p>
  </td>
  <td width=469 valign=top style='width:351.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>10</span></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>00</span></p>
  </td>
  <td width=469 valign=top style='width:351.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>1</span>번 사용자의 <span class=SpellE>출발층</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:3'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>10</span></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>01</span></p>
  </td>
  <td width=469 valign=top style='width:351.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>1</span>번 사용자의 <span class=SpellE>도착층</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:4'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>01</span></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>00</span></p>
  </td>
  <td width=469 valign=top style='width:351.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>2</span>번 사용자의 <span class=SpellE>출발층</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:5'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>01</span></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>10</span></p>
  </td>
  <td width=469 valign=top style='width:351.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>2</span>번 사용자의 <span class=SpellE>도착층</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:6'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>00</span></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>00</span></p>
  </td>
  <td width=469 valign=top style='width:351.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal>상황에 따라 판단</p>
  <p class=MsoListParagraph style='margin-left:40.0pt;mso-para-margin-left:
  0gd;text-indent:-18.0pt;mso-list:l2 level1 lfo3'><![if !supportLists]><span
  lang=EN-US style='mso-ascii-font-family:"맑은 고딕";mso-fareast-font-family:"맑은 고딕";
  mso-hansi-font-family:"맑은 고딕";mso-bidi-font-family:"맑은 고딕"'><span
  style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span></span><![endif]><span lang=EN-US>1</span>번<span lang=EN-US>, 2</span>번
  사용자 모두 위로 갈 경우<span lang=EN-US>: <b>1</b></span><b>번 사용자의 출발층과 <span
  lang=EN-US>2</span>번 사용자의 <span class=SpellE>출발층</span> 중 더 작은 층수</b></p>
  <p class=MsoListParagraph style='margin-left:40.0pt;mso-para-margin-left:
  0gd;text-indent:-18.0pt;mso-list:l2 level1 lfo3'><![if !supportLists]><span
  lang=EN-US style='mso-ascii-font-family:"맑은 고딕";mso-fareast-font-family:"맑은 고딕";
  mso-hansi-font-family:"맑은 고딕";mso-bidi-font-family:"맑은 고딕"'><span
  style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span></span><![endif]><span lang=EN-US>1</span>번<span lang=EN-US>, 2</span>번
  사용자 모두 아래로 갈 경우<span lang=EN-US>: <b>1</b></span><b>번 사용자의 출발층과 <span
  lang=EN-US>2</span>번 사용자의 <span class=SpellE>출발층</span> 중 더 큰 층수</b></p>
  <p class=MsoListParagraph style='margin-left:40.0pt;mso-para-margin-left:
  0gd;text-indent:-18.0pt;mso-list:l2 level1 lfo3'><![if !supportLists]><span
  lang=EN-US style='mso-ascii-font-family:"맑은 고딕";mso-fareast-font-family:"맑은 고딕";
  mso-hansi-font-family:"맑은 고딕";mso-bidi-font-family:"맑은 고딕"'><span
  style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span></span><![endif]><span lang=EN-US>1</span>번<span lang=EN-US>, 2</span>번
  사용자가 서로 다른 방향으로 갈 경우<span lang=EN-US>: <b>1</b></span><b>번 사용자의 <span
  class=SpellE>출발층</span></b> <span lang=EN-US>(</span>이 경우 임의의 사용자 <span
  class=SpellE>한명에</span> 대해 먼저 처리하면 다른 <span lang=EN-US>State</span>로 <span
  lang=EN-US>transition </span>되므로 <span lang=EN-US>1</span>번층을 우선적으로 선택하였다<span
  lang=EN-US>. )</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:7'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>00</span></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>01</span></p>
  </td>
  <td width=469 valign=top style='width:351.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal>상황에 따라 판단</p>
  <p class=MsoListParagraph style='margin-left:40.0pt;mso-para-margin-left:
  0gd;text-indent:-18.0pt;mso-list:l2 level1 lfo3'><![if !supportLists]><span
  lang=EN-US style='mso-ascii-font-family:"맑은 고딕";mso-fareast-font-family:"맑은 고딕";
  mso-hansi-font-family:"맑은 고딕";mso-bidi-font-family:"맑은 고딕"'><span
  style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span></span><![endif]><span lang=EN-US>1</span>번<span lang=EN-US>, 2</span>번
  사용자 모두 위로 갈 경우<span lang=EN-US>: </span>현재 <span lang=EN-US>1</span>번 사용자만 탑승해
  있으므로<span lang=EN-US>, 1</span>번 사용자의 도착층과 <span lang=EN-US>2</span>번 사용자의 출발층을
  비교하여 <span lang=EN-US>1</span>번 사용자의 도착층에 가는 중에 <span lang=EN-US>2</span>번 사용자의
  출발층을 거쳐가면<span lang=EN-US>, 2</span>번 사용자의 출발층에 가야하고<span lang=EN-US>, </span>그렇지
  않을 경우 <span lang=EN-US>1</span>번 사용자의 도착층에 가야한다<span lang=EN-US>. </span>따라서 <b><span
  lang=EN-US>1</span>번 사용자의 도착층과 <span lang=EN-US>2</span>번 사용자의 <span
  class=SpellE>출발층</span> 중 더 작은 층수</b></p>
  <p class=MsoListParagraph style='margin-left:40.0pt;mso-para-margin-left:
  0gd;text-indent:-18.0pt;mso-list:l2 level1 lfo3'><![if !supportLists]><span
  lang=EN-US style='mso-ascii-font-family:"맑은 고딕";mso-fareast-font-family:"맑은 고딕";
  mso-hansi-font-family:"맑은 고딕";mso-bidi-font-family:"맑은 고딕"'><span
  style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span></span><![endif]><span lang=EN-US>1</span>번<span lang=EN-US>, 2</span>번
  사용자 모두 아래로 갈 경우<span lang=EN-US>: </span>마찬가지로<span lang=EN-US>, </span>이 경우에는
  <b><span lang=EN-US>1</span>번 사용자의 도착층과 <span lang=EN-US>2</span>번 사용자의 <span
  class=SpellE>출발층</span> 중 더 큰 층수</b>를<b> </b>먼저 방문해야 한다<span lang=EN-US>.</span></p>
  <p class=MsoListParagraph style='margin-left:40.0pt;mso-para-margin-left:
  0gd;text-indent:-18.0pt;mso-list:l2 level1 lfo3'><![if !supportLists]><span
  lang=EN-US style='mso-ascii-font-family:"맑은 고딕";mso-fareast-font-family:"맑은 고딕";
  mso-hansi-font-family:"맑은 고딕";mso-bidi-font-family:"맑은 고딕"'><span
  style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span></span><![endif]><span lang=EN-US>1</span>번<span lang=EN-US>, 2</span>번
  사용자가 서로 다른 방향으로 갈 경우<span lang=EN-US>: </span>현재 <span lang=EN-US>1</span>번 사용자가
  탑승해 있으므로<span lang=EN-US>, </span>먼저 <span lang=EN-US>1</span>번 사용자를 도착층으로 데려가야
  한다<span lang=EN-US>. </span>따라서 <b><span lang=EN-US>1</span>번 사용자의 <span
  class=SpellE>도착층</span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:8'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>00</span></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>10</span></p>
  </td>
  <td width=469 valign=top style='width:351.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal>상황에 따라 판단 <span lang=EN-US>(Done 00, <span class=SpellE>On_board</span>
  01</span>의 상황과 유사<span lang=EN-US>)</span></p>
  <p class=MsoListParagraph style='margin-left:40.0pt;mso-para-margin-left:
  0gd;text-indent:-18.0pt;mso-list:l2 level1 lfo3'><![if !supportLists]><span
  lang=EN-US style='mso-ascii-font-family:"맑은 고딕";mso-fareast-font-family:"맑은 고딕";
  mso-hansi-font-family:"맑은 고딕";mso-bidi-font-family:"맑은 고딕"'><span
  style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span></span><![endif]><span lang=EN-US>1</span>번<span lang=EN-US>, 2</span>번
  사용자 모두 위로 갈 경우<span lang=EN-US>: </span>현재 <span lang=EN-US>2</span>번 사용자만 탑승해
  있으므로<span lang=EN-US>, 2</span>번 사용자의 도착층과 <span lang=EN-US>1</span>번 사용자의 출발층을
  비교하여<span lang=EN-US> 2</span>번 사용자의 도착층에 가는 사이에 <span lang=EN-US>1</span>번 사용자의
  출발층을 거쳐간다면 <span lang=EN-US>1</span>번 사용자의 출발층을 목적지로 삼아야 하고<span lang=EN-US>,
  </span>그렇지 않을 경우 <span lang=EN-US>2</span>번 사용자의 도착층에 도착해야 한다<span
  lang=EN-US>. </span>따라서<span lang=EN-US>, <b>1</b></span><b>번 사용자의 출발층과 <span
  lang=EN-US>2</span>번 사용자의 <span class=SpellE>도착층</span> 중 더 작은 층수</b></p>
  <p class=MsoListParagraph style='margin-left:40.0pt;mso-para-margin-left:
  0gd;text-indent:-18.0pt;mso-list:l2 level1 lfo3'><![if !supportLists]><span
  lang=EN-US style='mso-ascii-font-family:"맑은 고딕";mso-fareast-font-family:"맑은 고딕";
  mso-hansi-font-family:"맑은 고딕";mso-bidi-font-family:"맑은 고딕"'><span
  style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span></span><![endif]><span lang=EN-US>1</span>번<span lang=EN-US>, 2</span>번
  사용자 모두 아래로 갈 경우<span lang=EN-US>: </span>마찬가지로<span lang=EN-US>, </span>이 경우에는
  <b><span lang=EN-US>1</span>번 사용자의 출발층과 <span lang=EN-US>2</span>번 사용자의 <span
  class=SpellE>도착층</span> 중 더 높은 층수</b>를 먼저 방문해야 한다<span lang=EN-US>.</span></p>
  <p class=MsoListParagraph style='margin-left:40.0pt;mso-para-margin-left:
  0gd;text-indent:-18.0pt;mso-list:l2 level1 lfo3'><![if !supportLists]><span
  lang=EN-US style='mso-ascii-font-family:"맑은 고딕";mso-fareast-font-family:"맑은 고딕";
  mso-hansi-font-family:"맑은 고딕";mso-bidi-font-family:"맑은 고딕"'><span
  style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span></span><![endif]><span lang=EN-US>1</span>번<span lang=EN-US>, 2</span>번
  사용자가 서로 다른 방향으로 갈 경우<span lang=EN-US>: </span>현재 <span lang=EN-US>2</span>번 사용자가
  탑승해 있으므로<span lang=EN-US>, </span>먼저 <span lang=EN-US>2</span>번 사용자를 도착층으로 데려가야
  한다<span lang=EN-US>. </span>따라서 <b><span lang=EN-US>2</span>번 사용자의 <span
  class=SpellE>도착층</span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:9'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>00</span></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>11</span></p>
  </td>
  <td width=469 valign=top style='width:351.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal>상황에 따라 판단</p>
  <p class=MsoListParagraph style='margin-left:40.0pt;mso-para-margin-left:
  0gd;text-indent:-18.0pt;mso-list:l2 level1 lfo3'><![if !supportLists]><span
  lang=EN-US style='mso-ascii-font-family:"맑은 고딕";mso-fareast-font-family:"맑은 고딕";
  mso-hansi-font-family:"맑은 고딕";mso-bidi-font-family:"맑은 고딕"'><span
  style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span></span><![endif]><span lang=EN-US>1</span>번<span lang=EN-US>, 2</span>번
  사용자 모두 위로 갈 경우<span lang=EN-US>: <b>1</b></span><b>번 사용자의 도착층과 <span
  lang=EN-US>2</span>번 사용자의 <span class=SpellE>도착층</span> 중 더 작은 층수</b></p>
  <p class=MsoListParagraph style='margin-left:40.0pt;mso-para-margin-left:
  0gd;text-indent:-18.0pt;mso-list:l2 level1 lfo3'><![if !supportLists]><span
  lang=EN-US style='mso-ascii-font-family:"맑은 고딕";mso-fareast-font-family:"맑은 고딕";
  mso-hansi-font-family:"맑은 고딕";mso-bidi-font-family:"맑은 고딕"'><span
  style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span></span><![endif]><span lang=EN-US>1</span>번<span lang=EN-US>, 2</span>번
  사용자 모두 아래로 갈 경우<span lang=EN-US>: <b>1</b></span><b>번 사용자의 도착층과 <span
  lang=EN-US>2</span>번 사용자의 <span class=SpellE>도착층</span> 중 더 큰 층수</b></p>
  <p class=MsoListParagraph style='margin-left:40.0pt;mso-para-margin-left:
  0gd;text-indent:-18.0pt;mso-list:l2 level1 lfo3'><![if !supportLists]><span
  lang=EN-US style='mso-ascii-font-family:"맑은 고딕";mso-fareast-font-family:"맑은 고딕";
  mso-hansi-font-family:"맑은 고딕";mso-bidi-font-family:"맑은 고딕"'><span
  style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span></span><![endif]><span lang=EN-US>1</span>번<span lang=EN-US>, 2</span>번
  사용자가 서로 다른 방향으로 갈 경우<span lang=EN-US>: </span>서로 다른 방향으로 가는데 동시에 타고 있을 경우는 존재할
  수 없다<span lang=EN-US>. </span>따라서 이전의 출력을 유지한다<span lang=EN-US>.</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:10'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>11</span></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>01</span></p>
  </td>
  <td width=469 rowspan=7 valign=top style='width:351.8pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal>탑승한 사용자가 모두 도착층에 도착하였는데 <span class=SpellE>엘레베이터에</span> 탑승하고
  있을 경우는 존재할 수 없다<span lang=EN-US>. </span>따라서 이전의 출력을 유지한다<span lang=EN-US>.</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:11'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>11</span></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>10</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:12'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>11</span></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>11</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:13'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>10</span></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>10</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:14'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>10</span></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>11</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:15'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>01</span></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>01</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:16;mso-yfti-lastrow:yes'>
  <td width=56 valign=top style='width:42.3pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>01</span></p>
  </td>
  <td width=76 valign=top style='width:2.0cm;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>11</span></p>
  </td>
 </tr>
</table>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span lang=EN-US style='mso-no-proof:yes'><!--[if gte vml 1]><v:shape
 id="_x0000_i1028" type="#_x0000_t75" alt="텍스트, 스크린샷, 폰트이(가) 표시된 사진&#10;&#10;자동 생성된 설명"
 style='width:451pt;height:325pt;visibility:visible;mso-wrap-style:square'>
 <v:imagedata src="https://github.com/parkjbdev/verilog_elevator/blob/main/Elevator%20보고서.fld/image006.png" o:title="텍스트, 스크린샷, 폰트이(가) 표시된 사진&#10;&#10;자동 생성된 설명"/>
</v:shape><![endif]--><![if !vml]><img width=451 height=325
src="https://github.com/parkjbdev/verilog_elevator/blob/main/Elevator%20보고서.fld/image006.png"
alt="텍스트, 스크린샷, 폰트이(가) 표시된 사진&#10;&#10;자동 생성된 설명" v:shapes="_x0000_i1028"><![endif]></span></p>

<p class=MsoNormal>이를 작성한 코드는 위와 같다<span lang=EN-US>.</span></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<h2>타겟층 <span class=SpellE>이동단</span></h2>

<p class=MsoNormal>타겟층이 선택되었을 때<span lang=EN-US>, </span><span class=SpellE>엘레베이터의</span>
현재 층수와 비교하여 해당 타겟층으로 이동하는 역할을 한다<span lang=EN-US>. </span>해당 부분은<span
lang=EN-US> <span class=SpellE>target_controller</span> </span>모듈로 따로 선언하였다<span
lang=EN-US>. </span>해당 모듈은 타겟층과 현재 <span class=SpellE>엘레베이터의</span> 상태를 비교해서 엘리베이터에
올라가는 명령을 내릴지<span lang=EN-US>, </span>내려가는 명령을 내릴지<span lang=EN-US>, </span>문을 열지
닫을지에 대한 정보를 <span lang=EN-US>Elevator </span>모듈에 전달하는 중간 모듈이다<span lang=EN-US>.
</span><span class=SpellE>엘레베이터가</span> 각 동작을 수행할 때에<span lang=EN-US> 1</span>초씩
걸림을 고려하여 지연을 주었다<span lang=EN-US>.</span></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<h1><span lang=EN-US>Elevator </span>모듈</h1>

<p class=MsoNormal><span lang=EN-US>Elevator </span>모듈의 경우 총 <span lang=EN-US>10</span>가지
<span lang=EN-US>State</span>로 나눈 <span lang=EN-US>State Machine</span>을 구상하여 제작하였다<span
lang=EN-US>. </span>회로의 안정성을 위해서 그레이 코드를 이용하여 상태들을 <span class=SpellE>나타내었으며</span><span
lang=EN-US>, </span>각각의 상태들에 대한 <span class=SpellE>상태머신은</span> 다음과 같다<span
lang=EN-US>.</span></p>

<p class=MsoNormal><span lang=EN-US style='mso-no-proof:yes'><!--[if gte vml 1]><v:shape
 id="그림_x0020_1019255875" o:spid="_x0000_i1027" type="#_x0000_t75" style='width:451pt;
 height:281pt;visibility:visible;mso-wrap-style:square'>
 <v:imagedata src="https://github.com/parkjbdev/verilog_elevator/blob/main/Elevator%20보고서.fld/image007.png" o:title=""/>
</v:shape><![endif]--><![if !vml]><img width=451 height=281
src="https://github.com/parkjbdev/verilog_elevator/blob/main/Elevator%20보고서.fld/image007.png" v:shapes="그림_x0020_1019255875"><![endif]></span></p>

<p class=MsoNormal>상태에 대한 <span lang=EN-US>Notation</span>은 <span lang=EN-US>1Fc</span>는
<span lang=EN-US>floor1_closed, 2Fc</span>는 <span lang=EN-US>floor2_closed, 3Fo</span>는
<span lang=EN-US>floor3_closed </span>등등과 같으며<span lang=EN-US>, 3</span>가지 <span
lang=EN-US>input (</span>혹은<span lang=EN-US> DU</span><span class=SpellE>를</span>
하나의 버스로 생각한다면 <span lang=EN-US>2</span>가지 <span lang=EN-US>input, </span>실제 코드에서는
이와 같이 구현되어 있다<span lang=EN-US>.) </span>은 각각 <span lang=EN-US>O, D, U</span>로<span
lang=EN-US>, </span>각각<span lang=EN-US> Open, Down, Up</span>을 의미한다<span
lang=EN-US>. </span>즉<span lang=EN-US>, D’U</span>의 경우 내려가는 것에 대한 입력<span
lang=EN-US>, DU’</span>의 경우 올라가는 것에 대한 입력<span lang=EN-US>, DU </span>혹은 <span
lang=EN-US>D’U’</span>은 <span lang=EN-US>IDLE</span>상태로 있는 것에 대한 입력이며<span
lang=EN-US>, </span>올라가거나 <span class=SpellE>내려갈때는</span> 항상 문이 닫힌 상태로<span
lang=EN-US>, IDLE </span>상태일때는 문이 열리고 닫힌 상태 모두 가능하다<span lang=EN-US>. </span></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal>각각의 층에서 문이 <span class=SpellE>닫혀있는</span> 상태일 때<span
lang=EN-US>, </span>올라가는 입력 <span lang=EN-US>(O’D’U)</span>이 들어오면 위층의 닫힌 상태로 상태를
바꾸었으며<span lang=EN-US>, </span>반대로 내려가는 입력<span lang=EN-US> (O’DU’)</span>이 입력된다면
<span class=SpellE>아랫층의</span> 닫힌 상태로 상태를 바꾸었다<span lang=EN-US>. </span>또<span
lang=EN-US>, </span>문이 열리는 입력 <span lang=EN-US>(O)</span>이 입력된다면 해당 층에서 문이 열린 상태로
상태를 바꾸었으며<span lang=EN-US>, </span>문이 열린 상태에서 문을 닫는 입력<span lang=EN-US> (O’)</span>을
입력하였을 때에는 해당 층의 문이 닫힌 상태로 상태를 바꾸도록 하였다<span lang=EN-US>. 1</span>층에서 닫힌 상태로 있을 경우<span
lang=EN-US>, </span>만약 <span lang=EN-US>O’DU’ (</span>내려가는 입력<span lang=EN-US>)</span>과
같이 불가능한 입력이 들어온다면 해당 입력을 수행하지 않고 같은 상태로 유지하도록 하였으며<span lang=EN-US>, </span>이는 <span
lang=EN-US>5</span>층에서 <span lang=EN-US>O’D’U (</span>올라가는 입력<span lang=EN-US>)</span>에서도
마찬가지로 적용하였다<span lang=EN-US>. </span></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal>위의 <span class=SpellE>상태머신에서</span> 그레이 코드화 시켜 예기치 못한 오류를 최소화하도록
각각의 상태들을 할당하였다<span lang=EN-US>. </span>즉<span lang=EN-US>, </span>각각의 상태에 대한 코드는
다음과 같다<span lang=EN-US>.</span></p>

<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0
 style='border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-yfti-tbllook:1184;mso-padding-alt:0cm 5.4pt 0cm 5.4pt'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes'>
  <td width=150 valign=top style='width:112.7pt;border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>floor1_closed</span></p>
  </td>
  <td width=150 valign=top style='width:112.7pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>0001</span></p>
  </td>
  <td width=150 valign=top style='width:112.7pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>floor1_open</span></p>
  </td>
  <td width=150 valign=top style='width:112.7pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>1001</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1'>
  <td width=150 valign=top style='width:112.7pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>floor2_closed</span></p>
  </td>
  <td width=150 valign=top style='width:112.7pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>0011</span></p>
  </td>
  <td width=150 valign=top style='width:112.7pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>floor2_open</span></p>
  </td>
  <td width=150 valign=top style='width:112.7pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>1011</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2'>
  <td width=150 valign=top style='width:112.7pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>floor3_closed</span></p>
  </td>
  <td width=150 valign=top style='width:112.7pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>0010</span></p>
  </td>
  <td width=150 valign=top style='width:112.7pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>floor3_open</span></p>
  </td>
  <td width=150 valign=top style='width:112.7pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>1010</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:3'>
  <td width=150 valign=top style='width:112.7pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>floor4_closed</span></p>
  </td>
  <td width=150 valign=top style='width:112.7pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>0110</span></p>
  </td>
  <td width=150 valign=top style='width:112.7pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>floor4_open</span></p>
  </td>
  <td width=150 valign=top style='width:112.7pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>1110</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:4;mso-yfti-lastrow:yes'>
  <td width=150 valign=top style='width:112.7pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>floor5_closed</span></p>
  </td>
  <td width=150 valign=top style='width:112.7pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>0111</span></p>
  </td>
  <td width=150 valign=top style='width:112.7pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>floor5_open</span></p>
  </td>
  <td width=150 valign=top style='width:112.7pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>1111</span></p>
  </td>
 </tr>
</table>

<p class=MsoNormal>즉<span lang=EN-US>, MSB</span>는 문이 <span class=SpellE>열려있는지</span>
<span class=SpellE>닫혀있는지에</span> 대한 상태이며<span lang=EN-US>, </span>나머지 <span
lang=EN-US>3</span>비트는 각각의 층에 대한 그레이 코드이다<span lang=EN-US>. </span>위의 <span
class=SpellE>상태머신</span> 다이어그램을 참조하면 두가지 이상의 비트가 동시에 바뀌는 경우는 없음을 확인할 수 있다<span
lang=EN-US>.</span></p>

<p class=MsoNormal>최종적으로는<span lang=EN-US>, </span>각 상태를 문이 열렸는지 혹은 <span
class=SpellE>몇층인지로</span> 변환해주는 부분이 필요하여<span lang=EN-US>, </span>그레이 코드를 부호가 없는
<span lang=EN-US>binary</span>로 <span class=SpellE><span lang=EN-US>xor</span></span><span
lang=EN-US> </span>연산을 이용하여 변환해 주었으며<span lang=EN-US>, </span>문의 열림<span
lang=EN-US>/</span>닫힘 상태는 <span lang=EN-US>MSB </span>비트를 출력하여 각각의 상태에 대해서 변환한 값을
출력해주었다<span lang=EN-US>. </span></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal>실제 코드상에서 이를 구현할 때에는 문이 열리고 닫힐 때<span lang=EN-US> 1</span>초<span
lang=EN-US>, </span><span class=SpellE>엘레베이터가</span> 층을 이동할 때 <span lang=EN-US>1</span>초의
<span lang=EN-US>delay</span>가 있으므로 <span class=SpellE>클락을</span> 이용하여 다른 상태로 전환될
때 <span lang=EN-US>delay</span><span class=SpellE>를</span> 주어 이를 가상으로 구현하였다<span
lang=EN-US>. </span></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<h1><span class=SpellE>테스트벤치</span></h1>

<p class=MsoNormal><span class=SpellE>엘레베이터는</span> 초기상태로 <span lang=EN-US>1</span>층에서
문을 닫은 상태로 정지하고 있다고 가정하였다<span lang=EN-US>. </span>이는 <span class=SpellE>엘레베이터</span>
모듈에 정의되어 있다<span lang=EN-US>.</span></p>

<h2>예제 <span lang=EN-US>1</span></h2>

<p class=MsoNormal>해당 <span class=SpellE>테스트벤치는</span> 다음과 같은 입력을 가진다<span
lang=EN-US>. </span></p>

<p class=MsoListParagraph style='margin-left:40.0pt;mso-para-margin-left:0gd;
text-indent:-18.0pt;mso-list:l2 level1 lfo3'><![if !supportLists]><span
lang=EN-US style='mso-ascii-font-family:"맑은 고딕";mso-fareast-font-family:"맑은 고딕";
mso-hansi-font-family:"맑은 고딕";mso-bidi-font-family:"맑은 고딕"'><span
style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>초기상태 <span lang=EN-US>5</span>초딜레이</p>

<p class=MsoListParagraph style='margin-left:40.0pt;mso-para-margin-left:0gd;
text-indent:-18.0pt;mso-list:l2 level1 lfo3'><![if !supportLists]><span
lang=EN-US style='mso-ascii-font-family:"맑은 고딕";mso-fareast-font-family:"맑은 고딕";
mso-hansi-font-family:"맑은 고딕";mso-bidi-font-family:"맑은 고딕"'><span
style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=EN-US>4</span>층<span lang=EN-US>-&gt;2</span>층
<span lang=EN-US>5</span>초 딜레이</p>

<p class=MsoListParagraph style='margin-left:40.0pt;mso-para-margin-left:0gd;
text-indent:-18.0pt;mso-list:l2 level1 lfo3'><![if !supportLists]><span
lang=EN-US style='mso-ascii-font-family:"맑은 고딕";mso-fareast-font-family:"맑은 고딕";
mso-hansi-font-family:"맑은 고딕";mso-bidi-font-family:"맑은 고딕"'><span
style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=EN-US>5</span>층<span lang=EN-US>-&gt;3</span>층
<span lang=EN-US>14</span>초 딜레이 <span lang=EN-US>(</span><span class=SpellE>엘레베이터가</span>
이전 작업들을 마저 수행하기 위해서 기다리는 <span lang=EN-US>delay</span>로<span lang=EN-US>, </span>이전
수행중인 작업을 완료하기 위해서는 최소 <span lang=EN-US>11</span>초의 딜레이가 필요하다<span lang=EN-US>.
)</span></p>

<p class=MsoListParagraph style='margin-left:40.0pt;mso-para-margin-left:0gd;
text-indent:-18.0pt;mso-list:l2 level1 lfo3'><![if !supportLists]><span
lang=EN-US style='mso-ascii-font-family:"맑은 고딕";mso-fareast-font-family:"맑은 고딕";
mso-hansi-font-family:"맑은 고딕";mso-bidi-font-family:"맑은 고딕"'><span
style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=EN-US>4</span>층<span lang=EN-US>-&gt;3</span>층
</p>

<p class=MsoListParagraph style='margin-left:40.0pt;mso-para-margin-left:0gd;
text-indent:-18.0pt;mso-list:l2 level1 lfo3'><![if !supportLists]><span
lang=EN-US style='mso-ascii-font-family:"맑은 고딕";mso-fareast-font-family:"맑은 고딕";
mso-hansi-font-family:"맑은 고딕";mso-bidi-font-family:"맑은 고딕"'><span
style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span class=SpellE>끝날때까지</span> 충분히 딜레이</p>

<p class=MsoNormal><span lang=EN-US style='mso-no-proof:yes'><!--[if gte vml 1]><v:shape
 id="_x0000_i1026" type="#_x0000_t75" alt="스크린샷, 텍스트, 멀티미디어 소프트웨어, 그래픽 소프트웨어이(가) 표시된 사진&#10;&#10;자동 생성된 설명"
 style='width:452pt;height:102pt;visibility:visible;mso-wrap-style:square'>
 <v:imagedata src="https://github.com/parkjbdev/verilog_elevator/blob/main/Elevator%20보고서.fld/image008.png" o:title="스크린샷, 텍스트, 멀티미디어 소프트웨어, 그래픽 소프트웨어이(가) 표시된 사진&#10;&#10;자동 생성된 설명"/>
</v:shape><![endif]--><![if !vml]><img width=452 height=102
src="https://github.com/parkjbdev/verilog_elevator/blob/main/Elevator%20보고서.fld/image008.png"
alt="스크린샷, 텍스트, 멀티미디어 소프트웨어, 그래픽 소프트웨어이(가) 표시된 사진&#10;&#10;자동 생성된 설명" v:shapes="_x0000_i1026"><![endif]></span></p>

<p class=MsoNormal>의도하였던 대로<span lang=EN-US>, 1</span>층에 있는 <span class=SpellE>엘레베이터가</span>
<span lang=EN-US>4</span>층의 사용자를 데려가기 위해 <span lang=EN-US>4</span>층으로 이동중에 <span
lang=EN-US>5</span>층에서 내려가는 입력이 들어와 <span lang=EN-US>5</span>층을 우선적으로 방문하여 두명의 사용자를
같이 내려갈 수 있도록 <span class=SpellE><span lang=EN-US>target_floor_input</span></span>이
바뀌었고<span lang=EN-US>, </span>이에 따라 <span class=SpellE>엘레베이터도</span> <span
lang=EN-US>5</span>층을 우선적으로 방문하여 문을 열어 <span lang=EN-US>2</span>번 사용자를 태운다<span
lang=EN-US>. </span>그리고 순차적으로 <span lang=EN-US>4</span>층에 방문하여 <span
lang=EN-US>1</span>번 사용자도 태운 뒤<span lang=EN-US>, 2</span>번 사용자와 <span
lang=EN-US>1</span>번 사용자 각자의 목적지인<span lang=EN-US> 3</span>층과 <span lang=EN-US>2</span>층을
순차적으로 방문하여 사용자가 하차할 수 있음을 확인하였다<span lang=EN-US>. </span>또<span lang=EN-US>, 1</span>번
사용자의 목적지에 도달한 이후에도 새로운 사용자의 <span lang=EN-US>input</span>을 수행하기 위해서 <span
lang=EN-US>4</span>층으로 <span class=SpellE><span lang=EN-US>target_floor_input</span></span>이
<span class=SpellE>세팅되어</span> <span class=SpellE>엘레베이터가</span> 이동하였음을 확인하였다<span
lang=EN-US>. </span>그리고 마지막 사용자까지 최종 <span class=SpellE>도착층인</span> <span
lang=EN-US>2</span>층에 내려주고 <span lang=EN-US>idle </span>상태로 기다림을 확인할 수 있다<span
lang=EN-US>.</span></p>

<h2>예제 <span lang=EN-US>2</span></h2>

<p class=MsoNormal>해당 <span class=SpellE>테스트벤치는</span> 다음과 같은 입력을 가진다<span
lang=EN-US>.</span></p>

<p class=MsoListParagraph style='margin-left:40.0pt;mso-para-margin-left:0gd;
text-indent:-18.0pt;mso-list:l2 level1 lfo3'><![if !supportLists]><span
lang=EN-US style='mso-ascii-font-family:"맑은 고딕";mso-fareast-font-family:"맑은 고딕";
mso-hansi-font-family:"맑은 고딕";mso-bidi-font-family:"맑은 고딕"'><span
style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=EN-US>2</span>층<span lang=EN-US>-&gt;5</span>층
<span lang=EN-US>5</span>초 딜레이</p>

<p class=MsoListParagraph style='margin-left:40.0pt;mso-para-margin-left:0gd;
text-indent:-18.0pt;mso-list:l2 level1 lfo3'><![if !supportLists]><span
lang=EN-US style='mso-ascii-font-family:"맑은 고딕";mso-fareast-font-family:"맑은 고딕";
mso-hansi-font-family:"맑은 고딕";mso-bidi-font-family:"맑은 고딕"'><span
style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=EN-US>3</span>층<span lang=EN-US>-&gt;4</span>층
<span lang=EN-US>5</span>초 딜레이</p>

<p class=MsoListParagraph style='margin-left:40.0pt;mso-para-margin-left:0gd;
text-indent:-18.0pt;mso-list:l2 level1 lfo3'><![if !supportLists]><span
lang=EN-US style='mso-ascii-font-family:"맑은 고딕";mso-fareast-font-family:"맑은 고딕";
mso-hansi-font-family:"맑은 고딕";mso-bidi-font-family:"맑은 고딕"'><span
style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=EN-US>5</span>초 딜레이 <span lang=EN-US>(</span><span
class=SpellE>엘레베이터가</span> 이전 작업들을 마저 수행하기 위해서 기다리는 <span lang=EN-US>delay</span>로<span
lang=EN-US>, </span>이전 수행중인 작업을 완료하기 위해서는 최소 <span lang=EN-US>4</span>초의 딜레이가 필요하다<span
lang=EN-US>. )</span></p>

<p class=MsoListParagraph style='margin-left:40.0pt;mso-para-margin-left:0gd;
text-indent:-18.0pt;mso-list:l2 level1 lfo3'><![if !supportLists]><span
lang=EN-US style='mso-ascii-font-family:"맑은 고딕";mso-fareast-font-family:"맑은 고딕";
mso-hansi-font-family:"맑은 고딕";mso-bidi-font-family:"맑은 고딕"'><span
style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=EN-US>4</span>층<span lang=EN-US>-&gt;3</span>층</p>

<p class=MsoListParagraph style='margin-left:40.0pt;mso-para-margin-left:0gd;
text-indent:-18.0pt;mso-list:l2 level1 lfo3'><![if !supportLists]><span
lang=EN-US style='mso-ascii-font-family:"맑은 고딕";mso-fareast-font-family:"맑은 고딕";
mso-hansi-font-family:"맑은 고딕";mso-bidi-font-family:"맑은 고딕"'><span
style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span class=SpellE>끝날때까지</span> 충분히 딜레이</p>

<p class=MsoNormal><span lang=EN-US style='mso-no-proof:yes'><!--[if gte vml 1]><v:shape
 id="그림_x0020_1" o:spid="_x0000_i1025" type="#_x0000_t75" alt="스크린샷, 텍스트, 멀티미디어 소프트웨어, 그래픽 소프트웨어이(가) 표시된 사진&#10;&#10;자동 생성된 설명"
 style='width:452pt;height:126pt;visibility:visible;mso-wrap-style:square'>
 <v:imagedata src="https://github.com/parkjbdev/verilog_elevator/blob/main/Elevator%20보고서.fld/image009.png" o:title="스크린샷, 텍스트, 멀티미디어 소프트웨어, 그래픽 소프트웨어이(가) 표시된 사진&#10;&#10;자동 생성된 설명"/>
</v:shape><![endif]--><![if !vml]><img width=452 height=126
src="https://github.com/parkjbdev/verilog_elevator/blob/main/Elevator%20보고서.fld/image009.png"
alt="스크린샷, 텍스트, 멀티미디어 소프트웨어, 그래픽 소프트웨어이(가) 표시된 사진&#10;&#10;자동 생성된 설명" v:shapes="그림_x0020_1"><![endif]></span></p>

<p class=MsoNormal>의도하였던 대로<span lang=EN-US>, 1</span>층에서 <span lang=EN-US>4</span>층에
있는 첫번째 사용자를 태우기 위해 올라가던 중에 <span lang=EN-US>5</span>층에 있는 두번째 사용자가 입력하였기 때문에<span
lang=EN-US>, </span>효율을 위해서 <span lang=EN-US>5</span>층을 먼저 방문하여 두번째 사용자를 태운 뒤<span
lang=EN-US>, 4</span>층을 방문하여 첫번째 사용자를 태우고<span lang=EN-US>, </span>목표한 <span
lang=EN-US>3</span>층과 <span lang=EN-US>2</span>층으로 순차적으로 방문한다<span lang=EN-US>.
</span></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
