﻿<%@ Page CodeBehind="Default.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin._Default" CodePage="65001" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Register Assembly="Dynamicweb.UI.Controls" Namespace="Dynamicweb.UI.Controls" TagPrefix="dwc" %>
<%@ Register Assembly="Dynamicweb.UI.Controls" Namespace="Dynamicweb.UI.Controls" TagPrefix="dwc" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Core.UI.Icons" %>
<%@ Import Namespace="Dynamicweb.SystemTools" %>
<%@ Import Namespace="Dynamicweb.Core" %>

<!DOCTYPE html>
<html>
<head>
    <title>
        <dw:TranslateLabel runat="server" Text="Login" UseLabel="false" />
        (Dynamicweb <%=LicenseName%>)
    </title>
    <link id=​"favicon" rel=​"shortcut icon" type=​"image/​png" href=​"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAjCAYAAAD8BaggAAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAAABl0RVh0U29mdHdhcmUAcGFpbnQubmV0IDQuMC4xNkRpr/UAAAO6SURBVFhHxdhriExxGMfxmbWGJULJLUT7ArnzglzCC7mtvVhLvFgvlEvKpZYky2gnSiG5FK2sW5JsoZS0imQn8oLESrnk0koukcsuw/e35zkZ48zOMGbnqY/Z5pz///nNf845cw5fqlVYND0bhzDH/rYtGSoFQCXeYj6y9F5GiwAb8Q2vMQJ+25SZIsBaCxRBDQKwrS1cNPbjAL7jBxowF5lZJRoPwUtodRRIr5fQFrZXmiq6AX+3wTw8hBvG9QbDYHv/59LERqf1UJTjNr4iNozovaVIz9fGxN0QRB28Ang5iLQF0oq4B22yziPLFwr3xAbkwmZMsQqKpg/EXRokuzpSHQhe7kKIK/iOQ2j1b6E06Bd/YHONP2/O7H6EOkujRiQMVlA0I+irqN3P+G+I4Bl6w5okUxYArdEfJdiOYzjsq7i+dlzp8jKC1dL0E+IFe9R7zYGlBPrAOIX5Ya9FsGaJygkTwAycxmu4k0V70q78wmRCTaHxTijcE9TjMaqnlZSMI0w1+8aOPwIdV9bUq36tygCcwWd4BYl2EVpFHfC6APZAH3RHNis5mG3vETtPPbrCmnuVk3g2XiB6cHNeoh9sEqcI04T318HrQ+m9DbZ7nAqFZ+ItdCa4Eq3QO2gVbJKocs6k8/AaJxo7Fa1shMZIdtMr/+iAPYGtKMdhaLWaC6Wlz3Vmi6lQOAf3bD8vmvcNTmEztuA4dMw1TZDtzGTlpB2JB4gXSg072IjfKxRuD53iXuNcmlffRKP5ghWwSbwqFJ5rO3pNdtT2+rOcFbpj+ybjI5Ygy2aIU84l4CZiJ9AnKuTg1a1qV/RFL3SAxumM3WX7NqcB1zDROiZRofB6xH5t9yeULtMvvm7sH+AVnuEWKrk+5XcvqxrOfl4fRrQiumwsQCck+QPsHEsDoRVxJquojeSUX1xN4zC8rtC6cjcQ6s7khYuCgWDNSsZVQgftbizGILSDVtKaJVNOIA1yj4cIgWpmFRfoycIrjEuhIoRqxI284vxRbTdd0qVA1zsnxF8FiS5ncBn0tdX5K64PoNmWqObNcYPVY5LNmGI5gTpD9zO6d9YN/TZrmCwFO2kz/t9iYllljRJRkOfYC++LaKrFxDIB8QLo2ewRdmA8cpC+J1lNjM54itgwuv1Yg47QV+vub6PTUNZATx57EB3mPfLRFKRFSw0xGgrhBrqKzPzPh5pa831QGD2NVNnmzBQBRHeIehJRoFO2KXNFCB0vY6FTW/fVCX6tW6As1BicQ0d7O4Xy+X4CWmQNSw1g+usAAAAASUVORK5CYII=">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="robots" content="noindex,noarchive,nofollow" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta name="Cache-control" content="no-cache" />
    <meta http-equiv="Cache-control" content="no-cache" />

    <!-- Default control resources -->
    <dwc:ScriptLib runat="server" ID="ScriptLib1" />

    <!-- Needed non-default scripts -->
    <script type="text/javascript">
        var SpecifyUsernameText = "<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.Translate("Brugernavn"))%>";
        var SpecifyPasswordText = "<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.Translate("Adgangskode"))%>";
        var MissingText = "<%=Translate.JsTranslate("Please input username and password")%>";
        var waitMessage = "<i class=\"fa fa-refresh fa-spin\" id=\"waiting\"></i>";
        (function ($) {
            $(function () {
                $('#Username').keydown(function (e) { catchThatEnter2(e); });
                $('#Username').focus(function () { this.select(); });
                $('#Password').keydown(function (e) { catchThatEnter(e); });
                $('#Password').focus(function () { this.select(); });
            });
        })(window.jQuery);
    </script>
    <script src="Default.js" type="text/javascript"></script>
    <link href="Login.css" rel="stylesheet" />
</head>
<body onload="start();init();" class="area-blue login-screen label-top" style="background-image: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNDAwIiBoZWlnaHQ9IjUwMCIgb3BhY2l0eT0iLjQiPjxwYXRoIGQ9Ik0xMTYyIDk4N2wtMTQxMCAxIDE1NzQgMTR6IiBmaWxsPSIjNjI4NWFlIiBzdHJva2U9IiM2Mjg1YWUiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik02OTQtNzM0bDExMzEgMjE3IDExOC0yN3oiIGZpbGw9IiM2YThkYjYiIHN0cm9rZT0iIzZhOGRiNiIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTY5NC03MzRsMTI0OSAxOTAgNDk5LTk5eiIgZmlsbD0iIzYwODNhYyIgc3Ryb2tlPSIjNjA4M2FjIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMjQ0Mi02NDNsNzEgMjE0IDUxNiA3ODV6IiBmaWxsPSIjMmU0ZDcxIiBzdHJva2U9IiMyZTRkNzEiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0yNTEzLTQyOWw0OCAyMTMgNDY4IDU3MnoiIGZpbGw9IiMyNzQxNWYiIHN0cm9rZT0iIzI3NDE1ZiIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTI2NjIgMjcwbC02MCAyMjIgNDI3LTEzNnoiIGZpbGw9IiMxYzJkNDIiIHN0cm9rZT0iIzFjMmQ0MiIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTI2MDIgNDkybC03NyA0MjQgNTA0LTU2MHoiIGZpbGw9IiMyNjNmNWQiIHN0cm9rZT0iIzI2M2Y1ZCIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTI2MTQgNTlsNDggMjExIDM2NyA4NnoiIGZpbGw9IiMxODI2MzYiIHN0cm9rZT0iIzE4MjYzNiIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTI1NjEtMjE2bDUzIDI3NSA0MTUgMjk3eiIgZmlsbD0iIzFmMzM0YiIgc3Ryb2tlPSIjMWYzMzRiIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMjUxMy00MjlsLTE0IDE2MSA2MiA1MnoiIGZpbGw9IiMzNzU4N2YiIHN0cm9rZT0iIzM3NTg3ZiIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTIyNTUgNDQwbDI3MCA0NzYgNzctNDI0eiIgZmlsbD0iIzMzNGQ2ZCIgc3Ryb2tlPSIjMzM0ZDZkIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMjU2MS0yMTZsLTIwIDMzIDczIDI0MnoiIGZpbGw9IiMyZDQ4NjciIHN0cm9rZT0iIzJkNDg2NyIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTI1NDEtMTgzbC00MyAyMTQgMTE2IDI4eiIgZmlsbD0iIzJiNDM1ZSIgc3Ryb2tlPSIjMmI0MzVlIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMjYxNCA1OWwtNTcgMjMxIDEwNS0yMHoiIGZpbGw9IiMyMDJmNDEiIHN0cm9rZT0iIzIwMmY0MSIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTI1NTcgMjkwbDQ1IDIwMiA2MC0yMjJ6IiBmaWxsPSIjMjIzMzQ3IiBzdHJva2U9IiMyMjMzNDciIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0yNDk4IDMxbC0xMDMgMjMgMTYyIDIzNnoiIGZpbGw9IiMyOTNiNTAiIHN0cm9rZT0iIzI5M2I1MCIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTI1NTcgMjkwbC0zMDIgMTUwIDM0NyA1MnoiIGZpbGw9IiMyYjNlNTQiIHN0cm9rZT0iIzJiM2U1NCIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTI0OTggMzFsNTkgMjU5IDU3LTIzMXoiIGZpbGw9IiMyNjM3NGMiIHN0cm9rZT0iIzI2Mzc0YyIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTIyNTUgNDQwbC0yNjIgNTMwIDUzMi01NHoiIGZpbGw9IiM0MjYzODgiIHN0cm9rZT0iIzQyNjM4OCIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTIzMjAtMTQybDE3OCAxNzMgNDMtMjE0eiIgZmlsbD0iIzMzNGQ2YiIgc3Ryb2tlPSIjMzM0ZDZiIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMjQ5OS0yNjhsNDIgODUgMjAtMzN6IiBmaWxsPSIjMzM1Mjc1IiBzdHJva2U9IiMzMzUyNzUiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0yMzk1IDU0bC0xNDAgMzg2IDMwMi0xNTB6IiBmaWxsPSIjMjkzNzQ3IiBzdHJva2U9IiMyOTM3NDciIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0xNTc1IDkyNmwtMjQ5IDc2IDY2Ny0zMnoiIGZpbGw9IiM2Mzg2YWYiIHN0cm9rZT0iIzYzODZhZiIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTIzMjAtMTQybDc1IDE5NiAxMDMtMjN6IiBmaWxsPSIjMzI0OTY0IiBzdHJva2U9IiMzMjQ5NjQiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0yNDk5LTI2OGwtMTc5IDEyNiAyMjEtNDF6IiBmaWxsPSIjMzY1NDc2IiBzdHJva2U9IiMzNjU0NzYiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0yMTcwIDM5MGw4NSA1MCAxNDAtMzg2eiIgZmlsbD0iIzMwM2Y1MSIgc3Ryb2tlPSIjMzAzZjUxIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMjQ0Mi02NDNsLTQzMyAyMDIgNTA0IDEyeiIgZmlsbD0iIzQyNjU4ZSIgc3Ryb2tlPSIjNDI2NThlIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMjAwOS00NDFsMjYgMTI4IDQ3OC0xMTZ6IiBmaWxsPSIjNDg2Yjk0IiBzdHJva2U9IiM0ODZiOTQiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0yMzIwLTE0MmwxNzktMTI2IDE0LTE2MXoiIGZpbGw9IiMzYTVhODAiIHN0cm9rZT0iIzNhNWE4MCIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTIwMzUtMzEzbDI4NSAxNzEgMTkzLTI4N3oiIGZpbGw9IiM0MTYyODkiIHN0cm9rZT0iIzQxNjI4OSIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTE4ODggNjE0bDEwNSAzNTYgMjYyLTUzMHoiIGZpbGw9IiM0OTY2ODciIHN0cm9rZT0iIzQ5NjY4NyIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTIwODQgMTc0bDg2IDIxNiAyMjUtMzM2eiIgZmlsbD0iIzMzNDI1MyIgc3Ryb2tlPSIjMzM0MjUzIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMTk0My01NDRsNjYgMTAzIDQzMy0yMDJ6IiBmaWxsPSIjNGI2ZTk3IiBzdHJva2U9IiM0YjZlOTciIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0yMzIwLTE0MmwtMjM2IDMxNiAzMTEtMTIweiIgZmlsbD0iIzM3NGM2NSIgc3Ryb2tlPSIjMzc0YzY1IiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNNjk0LTczNGw0OTMgMjkwIDYzOC03M3oiIGZpbGw9IiM3Njk5YzIiIHN0cm9rZT0iIzc2OTljMiIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTIwMzggMzkwbC0xNTAgMjI0IDI4Mi0yMjR6IiBmaWxsPSIjNDI1NzcwIiBzdHJva2U9IiM0MjU3NzAiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0yMTcwIDM5MGwtMjgyIDIyNCAzNjctMTc0eiIgZmlsbD0iIzNmNTU2ZSIgc3Ryb2tlPSIjM2Y1NTZlIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMTkzMSA5MGwxNTMgODQgMjM2LTMxNnoiIGZpbGw9IiMzZTUzNmIiIHN0cm9rZT0iIzNlNTM2YiIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTIwMzUtMzEzTDE5MzEgOTBsMzg5LTIzMnoiIGZpbGw9IiM0NTVmN2YiIHN0cm9rZT0iIzQ1NWY3ZiIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTE4MTctMTMybDExNCAyMjIgMTA0LTQwM3oiIGZpbGw9IiM0YzY3ODYiIHN0cm9rZT0iIzRjNjc4NiIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTIwODQgMTc0bC00NiAyMTZoMTMyeiIgZmlsbD0iIzNhNDk1YyIgc3Ryb2tlPSIjM2E0OTVjIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMTkyNSA0MDhsLTM3IDIwNiAxNTAtMjI0eiIgZmlsbD0iIzQ2NWI3NCIgc3Ryb2tlPSIjNDY1Yjc0IiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMTg2NyAyNDNsMTcxIDE0NyA0Ni0yMTZ6IiBmaWxsPSIjM2Q0YjViIiBzdHJva2U9IiMzZDRiNWIiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0xOTMxIDkwbC02NCAxNTMgMjE3LTY5eiIgZmlsbD0iIzQxNTE2NCIgc3Ryb2tlPSIjNDE1MTY0IiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMTgzIDg0OWwtNDMxIDEzOSAxNDEwLTF6IiBmaWxsPSIjNTA3MzljIiBzdHJva2U9IiM1MDczOWMiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0yMDA5LTQ0MWwtMjU1IDc1IDI4MSA1M3oiIGZpbGw9IiM1NDc3YTAiIHN0cm9rZT0iIzU0NzdhMCIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTE3NTQtMzY2bDYzIDIzNCAyMTgtMTgxeiIgZmlsbD0iIzU1NzU5YSIgc3Ryb2tlPSIjNTU3NTlhIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMTg2NyAyNDNsNTggMTY1IDExMy0xOHoiIGZpbGw9IiM0MjUzNjciIHN0cm9rZT0iIzQyNTM2NyIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTE4ODggNjE0bC0zMTMgMzEyIDQxOCA0NHoiIGZpbGw9IiM1OTdjYTQiIHN0cm9rZT0iIzU5N2NhNCIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTE5NDMtNTQ0bC0xMTggMjcgMTg0IDc2eiIgZmlsbD0iIzU1NzhhMSIgc3Ryb2tlPSIjNTU3OGExIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMTgyNS01MTdsLTcxIDE1MSAyNTUtNzV6IiBmaWxsPSIjNTg3YmE0IiBzdHJva2U9IiM1ODdiYTQiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0xODQ3IDM5OWwtOTkgMTExIDE0MCAxMDR6IiBmaWxsPSIjNGQ2NDdlIiBzdHJva2U9IiM0ZDY0N2UiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0xODQ3IDM5OWw0MSAyMTUgMzctMjA2eiIgZmlsbD0iIzQ5NWY3OCIgc3Ryb2tlPSIjNDk1Zjc4IiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMTg2NyAyNDNsLTIwIDE1NiA3OCA5eiIgZmlsbD0iIzQ1NTY2YSIgc3Ryb2tlPSIjNDU1NjZhIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMTc4MSAzMTFsNjYgODggMjAtMTU2eiIgZmlsbD0iIzQ2NTY2OSIgc3Ryb2tlPSIjNDY1NjY5IiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMTgxNy0xMzJsNTAgMzc1IDY0LTE1M3oiIGZpbGw9IiM0ODVkNzQiIHN0cm9rZT0iIzQ4NWQ3NCIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTE4MTctMTMybC0yODYgNDA4IDMzNi0zM3oiIGZpbGw9IiM0ZDVlNzMiIHN0cm9rZT0iIzRkNWU3MyIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTE1MzEgMjc2bDI1MCAzNSA4Ni02OHoiIGZpbGw9IiM0YTU4NjkiIHN0cm9rZT0iIzRhNTg2OSIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTE3NDggNTEwbC0xNzMgNDE2IDMxMy0zMTJ6IiBmaWxsPSIjNTg3NTk3IiBzdHJva2U9IiM1ODc1OTciIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0xMzYzLTUwbDE2OCAzMjYgMjg2LTQwOHoiIGZpbGw9IiM1ODZkODYiIHN0cm9rZT0iIzU4NmQ4NiIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTE3ODEgMzExbC0zIDQgNjkgODR6IiBmaWxsPSIjNDk1OTZkIiBzdHJva2U9IiM0OTU5NmQiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0xNzc4IDMxNWwtOTIgMTE4IDE2MS0zNHoiIGZpbGw9IiM0YjVlNzMiIHN0cm9rZT0iIzRiNWU3MyIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTE2ODYgNDMzbDYyIDc3IDk5LTExMXoiIGZpbGw9IiM0ZTYzN2IiIHN0cm9rZT0iIzRlNjM3YiIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTEzNzQgNjc4bDIwMSAyNDggMTczLTQxNnoiIGZpbGw9IiM2MTdmYTEiIHN0cm9rZT0iIzYxN2ZhMSIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTE1NDggMjk5bDU0IDQzIDE3OS0zMXoiIGZpbGw9IiM0ZjVmNzEiIHN0cm9rZT0iIzRmNWY3MSIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTE1MzEgMjc2bDE3IDIzIDIzMyAxMnoiIGZpbGw9IiM1MDVmNzAiIHN0cm9rZT0iIzUwNWY3MCIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTEyODItMzMzbDQ3Mi0zMyA3MS0xNTF6IiBmaWxsPSIjNjM4NmFmIiBzdHJva2U9IiM2Mzg2YWYiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0xMTg3LTQ0NGw5NSAxMTEgNTQzLTE4NHoiIGZpbGw9IiM2YzhmYjgiIHN0cm9rZT0iIzZjOGZiOCIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTE3NTQtMzY2TDEzNjMtNTBsNDU0LTgyeiIgZmlsbD0iIzVjNzk5YiIgc3Ryb2tlPSIjNWM3OTliIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMTY3OCA0NDlsLTMwMyAxNjAgMzczLTk5eiIgZmlsbD0iIzU5NzA4YiIgc3Ryb2tlPSIjNTk3MDhiIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMTM3NSA2MDlsLTEgNjkgMzc0LTE2OHoiIGZpbGw9IiM2MDdhOTkiIHN0cm9rZT0iIzYwN2E5OSIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTEyODItMzMzbDgxIDI4MyAzOTEtMzE2eiIgZmlsbD0iIzY3ODdhYiIgc3Ryb2tlPSIjNjc4N2FiIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMTYwMiAzNDJsODQgOTEgOTItMTE4eiIgZmlsbD0iIzRmNjA3NSIgc3Ryb2tlPSIjNGY2MDc1IiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMTYwMiAzNDJsMTc2LTI3IDMtNHoiIGZpbGw9IiM0YzVjNmUiIHN0cm9rZT0iIzRjNWM2ZSIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTE2ODYgNDMzbC04IDE2IDcwIDYxeiIgZmlsbD0iIzUyNjc3ZiIgc3Ryb2tlPSIjNTI2NzdmIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMTUyMCA0MjNsLTE0NSAxODYgMzAzLTE2MHoiIGZpbGw9IiM1YjcxOGIiIHN0cm9rZT0iIzViNzE4YiIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTE2MDIgMzQybDc2IDEwNyA4LTE2eiIgZmlsbD0iIzUyNjU3YiIgc3Ryb2tlPSIjNTI2NTdiIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMTYwMiAzNDJsLTgyIDgxIDE1OCAyNnoiIGZpbGw9IiM1NDY3N2UiIHN0cm9rZT0iIzU0Njc3ZSIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTY5NC03MzRsMzk2IDI5MSA5Ny0xeiIgZmlsbD0iIzZkOTBiOSIgc3Ryb2tlPSIjNmQ5MGI5IiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMTM2My01MGwtNTAgMzA1IDIxOCAyMXoiIGZpbGw9IiM1YzZjODAiIHN0cm9rZT0iIzVjNmM4MCIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTEzNzQgNjc4bC01NSAxNDcgMjU2IDEwMXoiIGZpbGw9IiM2YjhkYjQiIHN0cm9rZT0iIzZiOGRiNCIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTE1NDggMjk5bC0yOCAxMjQgODItODF6IiBmaWxsPSIjNTU2NjdhIiBzdHJva2U9IiM1NTY2N2EiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0xMzYyIDQ5MWwxMyAxMTggMTQ1LTE4NnoiIGZpbGw9IiM2MTc3OTIiIHN0cm9rZT0iIzYxNzc5MiIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTEzMTkgODI1bDcgMTc3IDI0OS03NnoiIGZpbGw9IiM2ZTkxYmEiIHN0cm9rZT0iIzZlOTFiYSIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTEzMTMgMjU1bDIwNyAxNjggMTEtMTQ3eiIgZmlsbD0iIzU4Njg3YiIgc3Ryb2tlPSIjNTg2ODdiIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMTUzMSAyNzZsLTExIDE0NyAyOC0xMjR6IiBmaWxsPSIjNTU2Njc5IiBzdHJva2U9IiM1NTY2NzkiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0xMzEzIDI1NWw0OSAyMzYgMTU4LTY4eiIgZmlsbD0iIzVlNzA4NSIgc3Ryb2tlPSIjNWU3MDg1IiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMTMxMyAyNTVsLTE4MyAxMDUgMjMyIDEzMXoiIGZpbGw9IiM2Mzc1ODkiIHN0cm9rZT0iIzYzNzU4OSIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTExOTAtNDRsMTIzIDI5OSA1MC0zMDV6IiBmaWxsPSIjNjU3OTkxIiBzdHJva2U9IiM2NTc5OTEiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0xMjgyLTMzM2wtOTIgMjg5IDE3My02eiIgZmlsbD0iIzZjODhhOCIgc3Ryb2tlPSIjNmM4OGE4IiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMTA2MiA2MTZsMjU3IDIwOSA1NS0xNDd6IiBmaWxsPSIjNzA4ZWIxIiBzdHJva2U9IiM3MDhlYjEiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0xMzYwIDYwNmwxNCA3MiAxLTY5eiIgZmlsbD0iIzY4ODNhMiIgc3Ryb2tlPSIjNjg4M2EyIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMTM2MiA0OTFsLTIgMTE1IDE1IDN6IiBmaWxsPSIjNjU3ZTliIiBzdHJva2U9IiM2NTdlOWIiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0xMzYwIDYwNmwtMjk4IDEwIDMxMiA2MnoiIGZpbGw9IiM2ZDg4YTgiIHN0cm9rZT0iIzZkODhhOCIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTEzMTkgODI1bC0xNTcgMTYyIDE2NCAxNXoiIGZpbGw9IiM3NDk3YzAiIHN0cm9rZT0iIzc0OTdjMCIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTEwNjIgNjE2bDI5OC0xMCAyLTExNXoiIGZpbGw9IiM2Yjg0YTEiIHN0cm9rZT0iIzZiODRhMSIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTExMzAgMzYwbC02OCAyNTYgMzAwLTEyNXoiIGZpbGw9IiM2YTgwOWEiIHN0cm9rZT0iIzZhODA5YSIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTExOTAtNDRsLTg5IDMzMSAyMTItMzJ6IiBmaWxsPSIjNjU3NTg5IiBzdHJva2U9IiM2NTc1ODkiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0xMDYyIDYxNmwxMDAgMzcxIDE1Ny0xNjJ6IiBmaWxsPSIjNzU5N2JlIiBzdHJva2U9IiM3NTk3YmUiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0xMTAxIDI4N2wyOSA3MyAxODMtMTA1eiIgZmlsbD0iIzYzNzI4NCIgc3Ryb2tlPSIjNjM3Mjg0IiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMTE4Ny00NDRsLTk3IDEgMTkyIDExMHoiIGZpbGw9IiM3NzlhYzMiIHN0cm9rZT0iIzc3OWFjMyIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTkxMC0yNzZsMjgwIDIzMiA5Mi0yODl6IiBmaWxsPSIjNmY4ZWIxIiBzdHJva2U9IiM2ZjhlYjEiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0xMDkwLTQ0M0w5MTAtMjc2bDM3Mi01N3oiIGZpbGw9IiM3Mjk1YmUiIHN0cm9rZT0iIzcyOTViZSIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTk0NCAxODRsMTU3IDEwMyA4OS0zMzF6IiBmaWxsPSIjNjA3MTg1IiBzdHJva2U9IiM2MDcxODUiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik05MTAtMjc2bDM0IDQ2MCAyNDYtMjI4eiIgZmlsbD0iIzY0N2M5OCIgc3Ryb2tlPSIjNjQ3Yzk4IiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNNjk0LTczNGwyNSAyNDMgMzcxIDQ4eiIgZmlsbD0iIzY2ODliMiIgc3Ryb2tlPSIjNjY4OWIyIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNOTAxIDU0MmwxNjEgNzQgNjgtMjU2eiIgZmlsbD0iIzYzN2E5NCIgc3Ryb2tlPSIjNjM3YTk0IiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMTA2MiA2MTZsLTE2MS03NCAyNjEgNDQ1eiIgZmlsbD0iIzZiODlhZCIgc3Ryb2tlPSIjNmI4OWFkIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNOTAxIDU0MkwxODMgODQ5bDk3OSAxMzh6IiBmaWxsPSIjNjA4MWE3IiBzdHJva2U9IiM2MDgxYTciIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik05NjQgMzA3bC05NSAxMTcgMjYxLTY0eiIgZmlsbD0iIzVjNmQ4MiIgc3Ryb2tlPSIjNWM2ZDgyIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNODY5IDQyNGwzMiAxMTggMjI5LTE4MnoiIGZpbGw9IiM1ZTcyOGEiIHN0cm9rZT0iIzVlNzI4YSIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTExMDEgMjg3bC0xMzcgMjAgMTY2IDUzeiIgZmlsbD0iIzVlNmU4MCIgc3Ryb2tlPSIjNWU2ZTgwIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNOTQ0IDE4NGwyMCAxMjMgMTM3LTIweiIgZmlsbD0iIzU5Njc3NyIgc3Ryb2tlPSIjNTk2Nzc3IiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNOTEwLTI3Nkw3MjQgMTcybDIyMCAxMnoiIGZpbGw9IiM1YTZmODgiIHN0cm9rZT0iIzVhNmY4OCIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTcxOS00OTFsMTkxIDIxNSAxODAtMTY3eiIgZmlsbD0iIzY5OGNiNSIgc3Ryb2tlPSIjNjk4Y2I1IiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNNzE5LTQ5MWwyOCAxNDEgMTYzIDc0eiIgZmlsbD0iIzY0ODdiMCIgc3Ryb2tlPSIjNjQ4N2IwIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMzAyIDU2NkwxODMgODQ5bDcxOC0zMDd6IiBmaWxsPSIjNGQ2OThhIiBzdHJva2U9IiM0ZDY5OGEiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik03NDctMzUwbC0yMyA1MjIgMTg2LTQ0OHoiIGZpbGw9IiM1ZDc5OTkiIHN0cm9rZT0iIzVkNzk5OSIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTk0NCAxODRsLTIyMC0xMiAyNDAgMTM1eiIgZmlsbD0iIzU0NjI3MyIgc3Ryb2tlPSIjNTQ2MjczIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNNzI0IDE3MmwxNDUgMjUyIDk1LTExN3oiIGZpbGw9IiM1MzYzNzQiIHN0cm9rZT0iIzUzNjM3NCIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTUwNyAxMjRsMjE3IDQ4IDIzLTUyMnoiIGZpbGw9IiM1MjY5ODQiIHN0cm9rZT0iIzUyNjk4NCIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTcyNCAxNzJMNjIyIDM2M2wyNDcgNjF6IiBmaWxsPSIjNGU1ZTcxIiBzdHJva2U9IiM0ZTVlNzEiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik02MjIgMzYzTDMwMiA1NjZsNTk5LTI0eiIgZmlsbD0iIzRlNjQ3ZSIgc3Ryb2tlPSIjNGU2NDdlIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNODY5IDQyNGwtMjQ3LTYxIDI3OSAxNzl6IiBmaWxsPSIjNTY2YTgyIiBzdHJva2U9IiM1NjZhODIiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0zOTQgMzkzbC05MiAxNzMgMzIwLTIwM3oiIGZpbGw9IiM0NDU5NzAiIHN0cm9rZT0iIzQ0NTk3MCIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTY5NC03MzRsLTEzOCA1MiAxNjMgMTkxeiIgZmlsbD0iIzVlODFhYSIgc3Ryb2tlPSIjNWU4MWFhIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNNTU2LTY4Mmw3OSAyMTggODQtMjd6IiBmaWxsPSIjNWQ4MGE5IiBzdHJva2U9IiM1ZDgwYTkiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik02MzUtNDY0bC0zMjEgNjQgNDMzIDUweiIgZmlsbD0iIzU5N2NhNSIgc3Ryb2tlPSIjNTk3Y2E1IiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMzE0LTQwMGwxOTMgNTI0IDI0MC00NzR6IiBmaWxsPSIjNTI3MDkzIiBzdHJva2U9IiM1MjcwOTMiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik03MTktNDkxbC04NCAyNyAxMTIgMTE0eiIgZmlsbD0iIzYwODNhYyIgc3Ryb2tlPSIjNjA4M2FjIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNNTA3IDEyNGwxMTUgMjM5IDEwMi0xOTF6IiBmaWxsPSIjNDc1NjY3IiBzdHJva2U9IiM0NzU2NjciIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik01MDcgMTI0bC04NyAxMTQgMjAyIDEyNXoiIGZpbGw9IiM0MjRmNWYiIHN0cm9rZT0iIzQyNGY1ZiIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTU1Ni02ODJMMzE0LTQwMGwzMjEtNjR6IiBmaWxsPSIjNTY3OWEyIiBzdHJva2U9IiM1Njc5YTIiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0zMTQtNDAwTDUwLTU3bDQ1NyAxODF6IiBmaWxsPSIjNDM1ZTdkIiBzdHJva2U9IiM0MzVlN2QiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik00MjAgMjM4bC0yNiAxNTUgMjI4LTMweiIgZmlsbD0iIzQyNTM2NiIgc3Ryb2tlPSIjNDI1MzY2IiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMzgwIDI4OGwxNCAxMDUgMjYtMTU1eiIgZmlsbD0iIzNlNGQ1ZiIgc3Ryb2tlPSIjM2U0ZDVmIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNNTAtNTdsMTYxIDI0MCAyOTYtNTl6IiBmaWxsPSIjM2I0ZTY1IiBzdHJva2U9IiMzYjRlNjUiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0tMzE0LTM1OGw2MjgtNDIgMjQyLTI4MnoiIGZpbGw9IiM0NzZhOTMiIHN0cm9rZT0iIzQ3NmE5MyIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTM4MCAyODhsLTIgNCAxNiAxMDF6IiBmaWxsPSIjM2U0ZTYwIiBzdHJva2U9IiMzZTRlNjAiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0yMTEgMTgzbDIwOSA1NSA4Ny0xMTR6IiBmaWxsPSIjM2Q0ZDYwIiBzdHJva2U9IiMzZDRkNjAiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0zNzggMjkybC01NCA1NCA3MCA0N3oiIGZpbGw9IiMzZDRlNjIiIHN0cm9rZT0iIzNkNGU2MiIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTIzMyAyMTJsMTQ3IDc2IDQwLTUweiIgZmlsbD0iIzM5NDc1NyIgc3Ryb2tlPSIjMzk0NzU3IiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMjExIDE4M2wyMiAyOSAxODcgMjZ6IiBmaWxsPSIjMzg0NzU4IiBzdHJva2U9IiMzODQ3NTgiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0zMjQgMzQ2bC0yMiAyMjAgOTItMTczeiIgZmlsbD0iIzQwNTQ2YiIgc3Ryb2tlPSIjNDA1NDZiIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMjMzIDIxMmw5MSAxMzQgNTQtNTR6IiBmaWxsPSIjMzk0NzU4IiBzdHJva2U9IiMzOTQ3NTgiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0yMzMgMjEybDE0NSA4MCAyLTR6IiBmaWxsPSIjMzk0NzU3IiBzdHJva2U9IiMzOTQ3NTciIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik01MC01N0wzMCAzNWwxODEgMTQ4eiIgZmlsbD0iIzM0NDk2MSIgc3Ryb2tlPSIjMzQ0OTYxIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNODMgMzYwTDQ0IDU1OWwyNTggN3oiIGZpbGw9IiMzODRmNjgiIHN0cm9rZT0iIzM4NGY2OCIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTTQ0IDU1OWwxMzkgMjkwIDExOS0yODN6IiBmaWxsPSIjNDA1YzdkIiBzdHJva2U9IiM0MDVjN2QiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik04MyAzNjBsMjE5IDIwNiAyMi0yMjB6IiBmaWxsPSIjM2E0ZTY1IiBzdHJva2U9IiMzYTRlNjUiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0xNDkgMjgybC02NiA3OCAyNDEtMTR6IiBmaWxsPSIjMzQ0NTU4IiBzdHJva2U9IiMzNDQ1NTgiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0yMzMgMjEybC04NCA3MCAxNzUgNjR6IiBmaWxsPSIjMzU0NDU0IiBzdHJva2U9IiMzNTQ0NTQiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0tMzE0LTM1OEw1MC01N2wyNjQtMzQzeiIgZmlsbD0iIzNjNWM4MiIgc3Ryb2tlPSIjM2M1YzgyIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNNDQgNTU5bC02OCAzMyAyMDcgMjU3eiIgZmlsbD0iIzNiNTc3OCIgc3Ryb2tlPSIjM2I1Nzc4IiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMjExIDE4M2wtNjIgOTkgODQtNzB6IiBmaWxsPSIjMzM0MTUyIiBzdHJva2U9IiMzMzQxNTIiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0zMCAzNWwxMTkgMjQ3IDYyLTk5eiIgZmlsbD0iIzMyNDI1NSIgc3Ryb2tlPSIjMzI0MjU1IiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNLTI0IDU5MmwtMTAyIDU3IDMwOSAyMDB6IiBmaWxsPSIjMzk1Nzc5IiBzdHJva2U9IiMzOTU3NzkiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0tMTI2IDY0OWwtMTIyIDMzOSA0MzEtMTM5eiIgZmlsbD0iIzNhNWQ4NSIgc3Ryb2tlPSIjM2E1ZDg1IiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNLTE3MCAxMjhMODMgMzYwbDY2LTc4eiIgZmlsbD0iIzJhMzg0NyIgc3Ryb2tlPSIjMmEzODQ3IiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNMzAgMzVsLTIwMCA5MyAzMTkgMTU0eiIgZmlsbD0iIzJjM2U1MSIgc3Ryb2tlPSIjMmMzZTUxIiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNLTI5MC00M2w5MyA1Nkw1MC01N3oiIGZpbGw9IiMyYzQzNWYiIHN0cm9rZT0iIzJjNDM1ZiIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTS0zMTQtMzU4bDI0IDMxNUw1MC01N3oiIGZpbGw9IiMyZTRhNmIiIHN0cm9rZT0iIzJlNGE2YiIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTS0yNCA1OTJsNjgtMzMgMzktMTk5eiIgZmlsbD0iIzMzNGE2NCIgc3Ryb2tlPSIjMzM0YTY0IiBzdHJva2Utd2lkdGg9IjEuNTEiLz48cGF0aCBkPSJNLTIyNiAzODFsMjAyIDIxMUw4MyAzNjB6IiBmaWxsPSIjMmQ0MTU5IiBzdHJva2U9IiMyZDQxNTkiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0tMTcwIDEyOGwtNTYgMjUzIDMwOS0yMXoiIGZpbGw9IiMyNTM0NDUiIHN0cm9rZT0iIzI1MzQ0NSIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTS0xOTcgMTNMMzAgMzVsMjAtOTJ6IiBmaWxsPSIjMzA0NjYxIiBzdHJva2U9IiMzMDQ2NjEiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0tMTk3IDEzbDI3IDExNUwzMCAzNXoiIGZpbGw9IiMyYTNlNTYiIHN0cm9rZT0iIzJhM2U1NiIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTS0yNTggMTc5bDMyIDIwMiA1Ni0yNTN6IiBmaWxsPSIjMWYyZDNlIiBzdHJva2U9IiMxZjJkM2UiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0tMjI2IDM4MWwxMDAgMjY4IDEwMi01N3oiIGZpbGw9IiMyZDQ1NjEiIHN0cm9rZT0iIzJkNDU2MSIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTS0yMjYgMzgxbC00NDYtMTE2IDU0NiAzODR6IiBmaWxsPSIjMWYzMzRhIiBzdHJva2U9IiMxZjMzNGEiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0tNjcyIDI2NWw0MjQgNzIzIDEyMi0zMzl6IiBmaWxsPSIjMjY0MTYxIiBzdHJva2U9IiMyNjQxNjEiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0tMTk3IDEzbC02MSAxNjYgODgtNTF6IiBmaWxsPSIjMjQzNjRjIiBzdHJva2U9IiMyNDM2NGMiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0tMzE0LTM1OEwtNDkxLTk4bDIwMSA1NXoiIGZpbGw9IiMyNjQzNjQiIHN0cm9rZT0iIzI2NDM2NCIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTS0yOTAtNDNsMzIgMjIyIDYxLTE2NnoiIGZpbGw9IiMyNDM5NTEiIHN0cm9rZT0iIzI0Mzk1MSIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTS0yOTAtNDNsLTEzNCAyMjMgMTY2LTF6IiBmaWxsPSIjMWUzMTQ3IiBzdHJva2U9IiMxZTMxNDciIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0tMjU4IDE3OWwtMTY2IDEgMTk4IDIwMXoiIGZpbGw9IiMxYTI4MzgiIHN0cm9rZT0iIzFhMjgzOCIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTS00MjQgMTgwbC0yNDggODUgNDQ2IDExNnoiIGZpbGw9IiMxNjI1MzUiIHN0cm9rZT0iIzE2MjUzNSIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PHBhdGggZD0iTS00OTEtOThsNjcgMjc4IDEzNC0yMjN6IiBmaWxsPSIjMWUzNDRlIiBzdHJva2U9IiMxZTM0NGUiIHN0cm9rZS13aWR0aD0iMS41MSIvPjxwYXRoIGQ9Ik0tNDkxLTk4bC0xODEgMzYzIDI0OC04NXoiIGZpbGw9IiMxYTJkNDIiIHN0cm9rZT0iIzFhMmQ0MiIgc3Ryb2tlLXdpZHRoPSIxLjUxIi8+PC9zdmc+'),linear-gradient(342deg,#0085ca 50%,#004264);">
    <div class="dw-full-logo">
    </div>
    <div class="container login-container" id="container">
        <dwc:Card runat="server">
            <form id="login" name="login" action="" method="post" onsubmit="checkInput('Access_User_login.aspx');return true;">
                <dwc:CardBody runat="server">
                    <dw:Infobar ID="infoOldVersion" runat="server" Message="" Type="Warning">
                        Solution was last upgraded: <%=Me.BuildDate%>. Consider upgrade to newer version
                    </dw:Infobar>
                    <dw:Infobar ID="warnVersionProblem" runat="server" Message="" Type="Error">
                    </dw:Infobar>
                    <dw:Infobar ID="warnSolutionLocked" runat="server" Message="" Type="Error" Visible="false">
                        <%= Dynamicweb.Configuration.SystemConfiguration.Instance.GetValue("/Globalsettings/System/dblgnfornafemsg")%>
                    </dw:Infobar>
                    <dw:Infobar ID="warnTrialExpired" runat="server" Message="" Type="Error" Visible="false">
                    </dw:Infobar>

                    

                    <div class="col-md-6 col-sm-6 col-xs-12 form-group-full-width">
                        <h2><%=Translate.Translate("Sign in to")%><br />
                            Dynamicweb</h2>
                        <dwc:InputText runat="server" title="Brugernavn" Placeholder="Brugernavn" Value="" ID="Username" Name="Username" />

                        <dwc:InputText runat="server" Password="true" title="Kodeord" Placeholder="Kodeord" Value="" ID="Password" Name="Password" MaxLength="1000" />

                        <div>
                            <div id="warning" runat="server" style="display: none;">
                                <i class="<%=KnownIconInfo.ClassNameFor(KnownIcon.ExclaminationTriangle, True)%>"></i>
                                <span id="warningMsg" runat="server"></span>
                            </div>
                        </div>

                        <div id="cookieswarning" style="display: none;">
                            <div>
                                <i class="<%=KnownIconInfo.ClassNameFor(KnownIcon.ExclaminationTriangle, True)%>"></i>
                            </div>
                            <div><%=Translate.JsTranslate("Cookies must be enabled for using DynamicWeb")%></div>
                        </div>

                        <div style="display: none;">
                            <select title="<%=Translate.Translate("Sprog")%>" id="language" name="language" class="inputLang selectpicker" onchange="SetFormPath(document.getElementById('language').value);"><%= GetLanguageSelect(False)%></select>
                            <div class="spacer">
                            </div>
                        </div>

                        <% If Not Converter.ToBoolean(Dynamicweb.Configuration.SystemConfiguration.Instance.GetValue("/Globalsettings/Settings/CustomerAccess/HideRememberFeatures")) Then%>
                        <dwc:CheckBox runat="server" Label="Remember me on this computer" Name="usecookiea" ID="usecookiea" OnClick="cookieclick();" Indent="false" />
                        <span style="display: none;">
                            <input <%=chkb%> name="usecookieb" id="usecookieb" onclick="nescafecheck();" type="checkbox" />
                            <input <%=chkAutoLogin%> name="AutoLogin" id="AutoLogin" type="checkbox" value="True" />
                        </span>
                        <%End If%>

                        <div style="clear:both;">
                        <a class="btn btn-success" href="javascript:checkInput('Access_User_login.aspx');" id="loginBtn"><%=Translate.Translate("Sign in")%></a>&nbsp;&nbsp;<span id="waitingPlaceholder" style="display: none;"></span>
                            </div>
                       <%-- <a class="btn btn-success" href="javascript:signIn()">Sign In using Azure AD</a>--%>
 <h4 id="WelcomeMessage"></h4>
                        <br />
                        <br />
                        <!--b><%= Translate.Translate("Hjælp")%>:</!--b> <a href="" class="btn btn-link"><%= Translate.Translate("I forgot my username or password")%></a><br /-->

                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <div style="text-align: right">
                            <img src="/Admin/Resources/img/DW_logo_200.png" />
                        </div>
                        <div class="customlogo partner-box" id="customLogo" runat="server">
                            <div id="customLogoLicensedDiv" runat="server">
                                <h5><%= Translate.Translate("Licensed to")%>: </h5>
                                <div id="imageContainer">
                                    <img class="customlogoimg" id="imgPartnerLogo" runat="server" src="/Admin/Images/x.gif" alt="" />
                                </div>
                            </div>
                            <div id="customLogoPartnerInfoDiv" runat="server">
                                <%=CustomerInfo %>
                                <h5><%= Translate.Translate("Partner")%>: </h5>
                                <p class="partnerinfo">
                                    <%=PartnerInfo%>
                                </p>
                            </div>
                        </div>
                    </div>
                </dwc:CardBody>

                <dwc:CardFooter runat="server">
                    <span id="versionInfo" runat="server" visible="true"></span>
                    <span id="IsNightly" runat="server" visible="False">- Nightly build</span>

                    <div class="pull-right"><%=GetSmallFlag() %> <a href="#" onclick="return dialog.show('ChangeLanguage');" class="btn btn-link"><%= Translate.Translate("Change language")%></a></div>
                </dwc:CardFooter>
            </form>
        </dwc:Card>
    </div>

    <dw:Dialog ID="ChangeLanguage" runat="server" Title="Change language" Width="500">
        <div id="langSelect">
            <%= GetLanguageSelect(True)%>
        </div>
    </dw:Dialog>

    <dw:Dialog ID="BrowserCompability" runat="server" Title="Browser compability" ShowClose="true" Size="Small">
        <div>
            <p>
                <%=Translate.Translate("You are using a browser version which is not officially supported for the Dynamicweb administration interface. For a better experience, please use the latest versions of Microsoft Edge, Mozilla Firefox, Google Chrome or Apple Safari.")%>
            </p>
            <a href="http://doc.dynamicweb-cms.com/Default.aspx?ID=6819"><%=Translate.Translate("See the requirements")%></a>
        </div>
    </dw:Dialog>

    <script type="text/javascript">
        function getBrowserInfo() {
            var ua = navigator.userAgent, tem;
            var M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];

            if (/trident/i.test(M[1])) {
                tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
                return { name: 'IE', version: (tem[1] || '') };
            }
            if (M[1] === 'Chrome') {
                tem = ua.match(/\Edge\/(\d+)/)
                if (tem != null) { return { name: 'Edge', version: tem[1] }; }

                tem = ua.match(/\bOPR\/(\d+)/)
                if (tem != null) { return { name: 'Opera', version: tem[1] }; }
            }
            M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
            if ((tem = ua.match(/version\/(\d+)/i)) != null) { M.splice(1, 1, tem[1]); }

            return { name: M[0], version: M[1] };
        }

        var b = getBrowserInfo();
        if ((b.name === "Chrome" && b.version < 50) || (b.name === "Firefox" && b.version < 45) || (b.name === "Safari" && b.version < 9) || (b.name === "Edge" && b.version < 13) || (b.name === "IE" && b.version < 11)) {
            dialog.show('BrowserCompability');
        }
        else if (b.name !== "Chrome" && b.name !== "Firefox" && b.name !== "Safari" && b.name !== "Edge" && b.name !== "IE") {
            dialog.show('BrowserCompability');
        }
    </script>

    <script src="https://secure.aadcdn.microsoftonline-p.com/lib/1.0.12/js/adal.min.js"></script>
    <script>
        var ADAL = new AuthenticationContext({
            instance: 'https://login.microsoftonline.com/',
            tenant: 'common', //COMMON OR YOUR TENANT ID

            clientId: '6ce3266e-040b-4b99-8ef9-336bfcf8ca97', //This is your client ID
            redirectUri: 'http://localhost/Admin/Access/ExternalAuthentication.aspx', //This is your redirect URI

            callback: userSignedIn,
            popUp: true
        });

        function signIn() {
            ADAL.login();
        }

        function userSignedIn(err, token) {
            console.log('userSignedIn called');
            if (!err) {
                console.log("token: " + token);
                showWelcomeMessage();
            }
            else {
                console.error("error: " + err);
            }
        }

        function showWelcomeMessage() {
            var user = ADAL.getCachedUser();
            var profile = user.profile;
            console.log("user: " + user);
            var divWelcome = document.getElementById('WelcomeMessage');
            divWelcome.innerHTML = "Welcome " + user.profile.name + " (" + userName + ")";
        }

    </script>
</body>
</html>
<% 
    Translate.GetEditOnlineScript()
    Session.Abandon()
%>