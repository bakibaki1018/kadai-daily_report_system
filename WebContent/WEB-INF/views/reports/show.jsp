<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">
        <c:choose>
            <c:when test="${report != null}">
                <h2>日報 詳細ページ</h2>

                <table>
                    <tbody>
                        <tr>
                            <th>氏名</th>
                            <td><c:out value="${report.employee.name}" /></td>
                        </tr>
                        <tr>
                            <th>日付</th>
                            <td><fmt:formatDate value="${report.report_date}"
                                    pattern="yyyy-MM-dd" /></td>
                        </tr>
                        <tr>
                            <th>内容</th>
                            <td><pre><c:out value="${report.content}" /></pre></td>
                        </tr>
                        <tr>
                            <th>いいね！数</th>
                            <td>
                                <%--<c:out value="${いいね数を表示させる}"/>--%>
                            </td>
                        <tr>
                            <th>登録日時</th>
                            <td><fmt:formatDate value="${report.created_at}"
                                    pattern="yyyy-MM-dd HH:mm:ss" /></td>
                        </tr>
                        <tr>
                            <th>更新日時</th>
                            <td><fmt:formatDate value="${report.updated_at}"
                                    pattern="yyyy-MM-dd HH:mm:ss" /></td>
                        </tr>
                    </tbody>
                </table>

                <c:choose>

                    <%-- 条件：ログインIDと「いいね」したユーザーIDがおなじだったら「いいね済み」を表示する--%>
                    <c:when test="${sessionScope.login_employee == good.user_id}">
                        <form method="POST" action="<c:url value="/goods.destroy" />">
                            <input type="hidden" name="_token" value="${_token}" />
                            <button type="submit">いいね済み！</button>
                        </form>
                    </c:when>

                    <%-- 上記以外だったら「いいね」を表示する--%>
                    <c:otherwise>
                        <form method="POST" action="<c:url value="/goods.create" />">
                            <input type="hidden" name="_token" value="${_token}" />
                            <button type="submit">いいね!</button>
                        </form>
                    </c:otherwise>
                </c:choose>


                <c:if test="${sessionScope.login_employee.id != report.employee.id}">

                    <c:choose>
                        <c:when test="${sessionScope.login_employee == good.user_id}">
                            <form method="POST" action="<c:url value="/goods.destroy" />">
                                <input type="hidden" name="_token" value="${_token}" />
                                <button type="submit">フォロー中</button>
                            </form>

                        </c:when>
                        <%-- 上記以外だったら「フォローする」を表示する--%>
                        <c:otherwise>
                            <form method="POST" action="<c:url value="/goods.create" />">
                                <input type="hidden" name="_token" value="${_token}" />
                                <button type="submit">フォローする</button>
                            </form>
                        </c:otherwise>
                    </c:choose>

                </c:if>


                <c:if test="${sessionScope.login_employee.id == report.employee.id}">
                    <p>
                        <a href="<c:url value="/reports/edit?id=${report.id}" />">この日報を編集する</a>
                    </p>
                </c:if>
            </c:when>
            <c:otherwise>
                <h2>お探しのデータは見つかりませんでした。</h2>
            </c:otherwise>
        </c:choose>

        <p>
            <a href="<c:url value="/reports/index" />">一覧に戻る</a>
        </p>
    </c:param>
</c:import>