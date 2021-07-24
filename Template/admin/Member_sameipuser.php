{include file="Public/meta" /}
<title>同IP检测</title>
</head>
<body>

<div class="page-container">
	<table class="table table-border table-bordered table-hover table-bg table-sort">
		<thead>
			<tr class="text-c">
				<th width="120">IP</th>
				<th >登录用户</th>
			</tr>
		</thead>
		<tbody>
			{volist name="list" id="vo"}
            <tr class="text-c">
                <td>{$vo.ip}</td>
                <td>{$vo.members}</td>
			</tr>
            {/volist}
		</tbody>
	</table>
    
    <div class="cl pd-5 bg-1 bk-gray mt-20 text-c">
        <div class="pageNav l" style="padding:0">{$page}</div>
        <div class="r">共有数据：<strong>{$totalcount}</strong> 条 </div>
    </div>
    </form>
	</div>
</div>
{include file="Public/footer" /}
</body>
</html>