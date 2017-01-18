<script>
    function AjaxFormRequest(result_id,formMain,url) 
    {
        jQuery.ajax(
        {
            url: url,
            type: "POST",
            dataType: "html",
            data: jQuery("#"+formMain).serialize(),
            success: function(response) {
            document.getElementById(result_id).innerHTML = response;
            },
            error: function(response) 
            {
                document.getElementById(result_id).innerHTML = "Возникла ошибка при отправке формы. Попробуйте еще раз";
            }
        });
        $("#formMain").hide().html();
    }
    function AjaxFormRequest1(result_id, formPay, url) 
    {
        jQuery.ajax(
        {
            url: url,
            type: "POST",
            dataType: "html",
            data: jQuery("#"+formPay).serialize(),
            success: function(response) {
            document.getElementById(result_id).innerHTML = response;
            },
            error: function(response) 
            {
                document.getElementById(result_id).innerHTML = "Возникла ошибка при отправке формы. Попробуйте еще раз";
            }
        });
        $("#formPay").hide().html();
    }
</script>

<div class="cabinet">
    <h1>Кабинет пользователя</h1>
    <div class="hello">Здравствуйте, <?php echo $this->account['username']?></div>
    <div class="text">Доступные вам функции</div>
    <div class="contblock">
        <div class="grid">
            <div class="cell">
                <h4>Кредиты</h4>
                <div class="cell-content">
                    <div class="credits">
                    <?php 
                    $credits = $this->credits;
                    
                    $summ = 0;
                    $payments = $this->payments;
                    foreach($payments as $payment)
                    {
                        if($payment["confirmed"])
                        {
                            $summ += $payment['payment'];
                        }
                    }

                    if($credits == 0)
                    {
                        echo "Кредитов нет";
                    }
                    else
                    {
                        foreach($credits as $credit)
                        {
                            echo "<div class=\"credit\">";
                            
                           
                            $datetime1 = new DateTime(date("Y-m-d"));
                            $datetime2 = new DateTime($credit["date"]);
                            $diff = date_diff($datetime1, $datetime2);
                            $days = $diff->format("%a");

                            $debt_total = $credit["quantity"]*(1 + $credit["percents"]/ 36500 * $days);
                            $debt_total = ceil($debt_total);
                            $debt = $debt_total - $summ;

                            echo $debt_total." (".$credit["quantity"].") </br> (оплачено: ".$summ.", осталось: ".$debt.")";
                            echo "</div>";
                        }
                    }
                    ?>
                    </div>
                </div>
            </div>
            <div class="cell">
                <h4>Платежи</h4>
                <div class="cell-content">
                    <div class="payments">
                    <?php
                    $summ = 0;
                    $payments = $this->payments;
                        foreach($payments as $payment)
                        {
                            echo "<div class=\"payment\">";
                            echo $payment['date']. " ".$payment['payment'];
                            if($payment["confirmed"])
                            {
                                $summ += $payment['payment'];
                                echo "(подтверждён)";
                            }
                            else echo "(не подтверждён)";
                            echo "</div>";
                        }
                    ?>
                    </div>
                </div>
            </div>
            <div class="cell">
                <h4>Отправить заявку</h4>
                <div class="cell-content">
                    <div class="form">
                        <div id="messegeResult">Оставьте ваши контакты и наш консультант свяжется с вами </div>
                        <form method="post" action="" id="formMain">
                                <input id="quantity" type="text" name="quantity" placeholder="Сумма" maxlength="30" autocomplete="off" />
                                <input id="percents" type="text" name="percents" placeholder="Процент" maxlength="30" autocomplete="off"/>
                                <input id="days" type="date" name="days" placeholder="Количество дней" maxlength="30" autocomplete="off"/>
                                <input id="phone" type="text" name="phone" placeholder="Введите ваш телефон" maxlength="30" autocomplete="off"/>
                                <input id="button" type="button"  value="Отправить запрос" onclick="AjaxFormRequest('messegeResult', 'formMain', 'form.php')"/>

                        </form>
                    </div>
                </div>
            </div>
            <div class="cell">
                <h4>Подтвердить платёж</h4>
                <div class="cell-content">
                    <div class="form">
                        <div id="messegeResult1">Оставьте ваши контакты и наш консультант свяжется с вами </div>
                        <form method="post" action="" id="formPay">
                                <input id="date" type="date" name="date" placeholder="Дата" maxlength="30" autocomplete="off" />
                                <input id="payment" type="text" name="payment" placeholder="Платёж" maxlength="30" autocomplete="off"/>
                                <input id="secret" type="text" name="secret" placeholder="Секрет" maxlength="30" autocomplete="off"/>

                                <input id="button" type="button"  value="Отправить данные" onclick="AjaxFormRequest1('messegeResult1', 'formPay', 'pay.php')"/>
                        </form>
                    </div>
                </div>
            </div>
        </div>      
            
    </div>
</div>