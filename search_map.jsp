import React, { useState, useEffect } from 'react';
import { Search, BarChart2, Database, Settings, HelpCircle, Shield, FileText, Info, ExternalLink, Users, Briefcase, Link as LinkIcon } from 'lucide-react';

// Tailwind CSS를 사용하므로 별도의 CSS 파일은 필요하지 않습니다.
// package.json에 "lucide-react"가 추가되어 있다고 가정합니다.

const App = () => {
  const [searchTerm, setSearchTerm] = useState('');
  const [currentPage, setCurrentPage] = useState('home'); // 'home', 'results', 'trends'
  const [searchResults, setSearchResults] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [knowledgePanelData, setKnowledgePanelData] = useState(null);

  // 실제 API 호출 대신 사용할 목업 검색 함수
  const performSearch = async (term) => {
    if (!term.trim()) {
      setSearchResults([]);
      setKnowledgePanelData(null);
      setCurrentPage('home');
      return;
    }
    setIsLoading(true);
    setKnowledgePanelData(null); // 검색 시작 시 패널 데이터 초기화
    
    // 가짜 API 지연 시간
    await new Promise(resolve => setTimeout(resolve, 1000));
    
    // 가짜 검색 결과 생성
    const fakeResults = [
      { id: 1, title: `${term} 관련 오픈 데이터 세트 1`, description: '이것은 첫 번째 검색 결과에 대한 설명입니다. 다양한 공공 데이터를 포함합니다. 이 데이터 세트는 정부 기관에서 제공하며, API를 통해 접근 가능합니다.', source: '공공데이터포털', lastUpdated: '2024-05-27', url: '#', type: 'dataset' },
      { id: 2, title: `"${term}" 키워드 트렌드 분석 보고서`, description: '최근 1년간 "${term}" 키워드의 검색 빈도 및 관련 기술 동향 분석. 이 보고서는 시장 조사 기관에서 발행했습니다.', source: '자체 분석 시스템', lastUpdated: '2024-05-20', url: '#', type: 'report' },
      { id: 3, title: `${term} 기술 활용 사례 연구`, description: '오픈 소스 프로젝트 및 기업에서의 ${term} 기술 활용 사례 모음. 실제 적용된 다양한 프로젝트를 소개합니다.', source: '기술 블로그 모음', lastUpdated: '2024-05-15', url: '#', type: 'article' },
      { id: 4, title: `오픈 API: ${term} 데이터 접근`, description: '실시간 ${term} 관련 데이터를 제공하는 오픈 API 명세. 개발자들이 쉽게 연동할 수 있도록 문서화되어 있습니다.', source: '개발자 센터', lastUpdated: '2024-05-28', url: '#', type: 'api' },
    ];
    setSearchResults(fakeResults);

    // 가짜 지식 패널 데이터 생성 (검색어 기반)
    // 실제로는 검색어에 따라 동적으로 생성되어야 합니다.
    if (term.toLowerCase().includes("인공지능") || term.toLowerCase().includes("ai")) {
        setKnowledgePanelData({
            title: "인공지능 (Artificial Intelligence)",
            subtitle: "컴퓨터 과학 분야",
            description: "인공지능은 인간의 학습능력, 추론능력, 지각능력, 자연언어의 이해능력 등을 컴퓨터 프로그램으로 실현한 기술입니다. 기계 학습, 딥러닝, 자연어 처리 등 다양한 세부 분야를 포함합니다.",
            sourceName: "위키백과",
            sourceUrl: "https://ko.wikipedia.org/wiki/%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5",
            imageUrl: "https://placehold.co/400x300/E0E7FF/4F46E5?text=AI+Image", // Placeholder image
            details: [
                { label: "주요 분야", value: "기계 학습, 딥러닝, NLP, 컴퓨터 비전" },
                { label: "응용 분야", value: "자율주행, 의료 진단, 금융 분석, 챗봇" },
            ],
            relatedLinks: [
                { text: "OpenAI", url: "#" },
                { text: "DeepMind", url: "#" },
                { text: "한국인공지능학회", url: "#" },
            ]
        });
    } else if (term.toLowerCase().includes("데이터") || term.toLowerCase().includes("data")) {
         setKnowledgePanelData({
            title: "데이터 (Data)",
            subtitle: "정보의 단위",
            description: "데이터는 현실 세계에서 관찰하거나 측정하여 얻은 사실이나 값입니다. 가공되지 않은 상태의 자료를 의미하며, 분석과 해석을 통해 정보로서의 가치를 갖게 됩니다.",
            sourceName: "나무위키",
            sourceUrl: "#", // 실제 링크로 대체 필요
            imageUrl: "https://placehold.co/400x300/D1FAE5/059669?text=Data+Image",
            details: [
                { label: "유형", value: "정형, 반정형, 비정형 데이터" },
                { label: "중요성", value: "의사결정 지원, 예측 분석, 서비스 개선" },
            ],
            relatedLinks: [
                { text: "공공데이터포털", url: "https://www.data.go.kr/" },
                { text: "Kaggle (데이터 과학 플랫폼)", url: "https://www.kaggle.com/" },
            ]
        });
    }


    setIsLoading(false);
    setCurrentPage('results');
  };
  
  const handleResultItemClick = (resultItem) => {
    // 클릭된 결과 항목에 대한 지식 패널 데이터 설정 (예시)
    // 실제로는 resultItem의 상세 정보를 바탕으로 패널 데이터를 구성해야 합니다.
    setKnowledgePanelData({
        title: resultItem.title,
        subtitle: `출처: ${resultItem.source} (${resultItem.type})`,
        description: resultItem.description,
        sourceName: resultItem.source,
        sourceUrl: resultItem.url,
        imageUrl: `https://placehold.co/400x300/FEF3C7/D97706?text=${encodeURIComponent(resultItem.type)}`,
        details: [
            { label: "최종 업데이트", value: resultItem.lastUpdated },
            { label: "데이터 유형", value: resultItem.type.toUpperCase() },
        ],
        relatedLinks: [
            { text: "원본 링크", url: resultItem.url },
        ]
    });
  };


  const handleSearch = (e) => {
    e.preventDefault();
    performSearch(searchTerm);
  };

  const Header = () => (
    <header className="bg-white dark:bg-gray-900 shadow-sm sticky top-0 z-50">
      <div className="container mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between h-16">
          <div className="flex items-center">
            <a href="#" onClick={() => { setCurrentPage('home'); setSearchTerm(''); setSearchResults([]); setKnowledgePanelData(null); }} className="flex items-center text-2xl font-bold text-blue-600 dark:text-blue-400">
              <Database className="w-8 h-8 mr-2" />
              <span>데이터 파인더</span>
            </a>
          </div>
          {currentPage === 'results' && (
            <div className="flex-grow max-w-xl mx-4 hidden sm:block">
              <form onSubmit={handleSearch} className="relative">
                <input
                  type="text"
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                  placeholder="기술 키워드 검색..."
                  className="w-full py-2.5 px-4 pr-12 text-gray-700 dark:text-gray-200 bg-gray-100 dark:bg-gray-800 border border-gray-300 dark:border-gray-700 rounded-full focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors"
                />
                <button type="submit" className="absolute right-0 top-0 h-full px-4 text-blue-600 dark:text-blue-400 hover:text-blue-700 dark:hover:text-blue-300">
                  <Search className="w-5 h-5" />
                </button>
              </form>
            </div>
          )}
          <nav className="flex items-center space-x-4">
            <a 
              href="#" 
              onClick={() => setCurrentPage('home')} 
              className={`px-3 py-2 rounded-md text-sm font-medium ${currentPage === 'home' || currentPage === 'results' ? 'text-blue-600 dark:text-blue-400' : 'text-gray-600 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400'}`}
            >
              데이터 검색
            </a>
            <a 
              href="#" 
              onClick={() => setCurrentPage('trends')} 
              className={`px-3 py-2 rounded-md text-sm font-medium ${currentPage === 'trends' ? 'text-blue-600 dark:text-blue-400' : 'text-gray-600 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400'}`}
            >
              트렌드 분석
            </a>
          </nav>
        </div>
         {currentPage === 'results' && (
            <div className="sm:hidden py-2">
              <form onSubmit={handleSearch} className="relative">
                <input
                  type="text"
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                  placeholder="기술 키워드 검색..."
                  className="w-full py-2.5 px-4 pr-12 text-gray-700 dark:text-gray-200 bg-gray-100 dark:bg-gray-800 border border-gray-300 dark:border-gray-700 rounded-full focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors"
                />
                <button type="submit" className="absolute right-0 top-0 h-full px-4 text-blue-600 dark:text-blue-400 hover:text-blue-700 dark:hover:text-blue-300">
                  <Search className="w-5 h-5" />
                </button>
              </form>
            </div>
          )}
      </div>
    </header>
  );

  const SearchBarComponent = ({ onSearch, term, setTerm, isCentered = false }) => (
    <form onSubmit={onSearch} className={`w-full ${isCentered ? 'max-w-2xl' : 'max-w-xl'}`}>
      <div className="relative flex items-center bg-white dark:bg-gray-800 shadow-lg rounded-full border border-gray-200 dark:border-gray-700 hover:shadow-xl focus-within:shadow-xl transition-shadow duration-200">
        <input
          type="text"
          value={term}
          onChange={(e) => setTerm(e.target.value)}
          placeholder="AI, 빅데이터, 클라우드 등 기술 키워드를 입력하세요"
          className="w-full py-4 px-6 text-gray-700 dark:text-gray-200 bg-transparent rounded-full focus:outline-none appearance-none"
          style={{ WebkitAppearance: 'none', MozAppearance: 'none' }}
        />
        <button 
          type="submit" 
          className="p-3 text-blue-600 dark:text-blue-400 hover:bg-blue-100 dark:hover:bg-gray-700 rounded-full m-1 transition-colors"
          aria-label="검색"
        >
          <Search className="w-6 h-6" />
        </button>
      </div>
    </form>
  );

  const HomePage = () => (
    <div className="flex flex-col items-center justify-center min-h-[calc(100vh-16rem)] text-center px-4">
      <div className="mb-12">
        <h1 className="text-5xl sm:text-6xl font-extrabold text-transparent bg-clip-text bg-gradient-to-r from-blue-600 via-sky-500 to-cyan-400 mb-4">
          데이터 파인더
        </h1>
        <p className="text-lg text-gray-600 dark:text-gray-300">
          기술 키워드로 방대한 오픈 데이터를 검색하고, 최신 트렌드를 분석하세요.
        </p>
      </div>
      <SearchBarComponent onSearch={handleSearch} term={searchTerm} setTerm={setSearchTerm} isCentered={true} />
      <div className="mt-8 text-sm text-gray-500 dark:text-gray-400">
        예: <button onClick={() => { setSearchTerm('인공지능 의료'); performSearch('인공지능 의료'); }} className="text-blue-500 hover:underline">인공지능 의료</button>, 
        <button onClick={() => { setSearchTerm('자율주행 기술'); performSearch('자율주행 기술'); }} className="ml-2 text-blue-500 hover:underline">자율주행 기술</button>,
        <button onClick={() => { setSearchTerm('ESG 데이터'); performSearch('ESG 데이터'); }} className="ml-2 text-blue-500 hover:underline">ESG 데이터</button>
      </div>
    </div>
  );

  const KnowledgePanel = ({ data }) => {
    if (!data) return null;

    return (
      <div className="w-full lg:w-2/5 xl:w-1/3 bg-white dark:bg-gray-800 rounded-lg shadow-lg p-6 sticky top-20 self-start">
        {data.imageUrl && (
          <img 
            src={data.imageUrl} 
            alt={data.title} 
            className="w-full h-48 object-cover rounded-md mb-4"
            onError={(e) => { e.target.onerror = null; e.target.src="https://placehold.co/400x300/ccc/999?text=Image+Not+Found"; }}
          />
        )}
        <h2 className="text-2xl font-bold text-gray-800 dark:text-white mb-1">{data.title}</h2>
        {data.subtitle && <p className="text-sm text-gray-500 dark:text-gray-400 mb-3">{data.subtitle}</p>}
        <p className="text-gray-700 dark:text-gray-300 mb-4 text-sm leading-relaxed">{data.description}</p>
        
        {data.details && data.details.length > 0 && (
          <div className="mb-4">
            {data.details.map((detail, index) => (
              <div key={index} className="text-sm mb-1">
                <span className="font-semibold text-gray-600 dark:text-gray-300">{detail.label}: </span>
                <span className="text-gray-500 dark:text-gray-400">{detail.value}</span>
              </div>
            ))}
          </div>
        )}

        {data.sourceName && (
          <p className="text-xs text-gray-500 dark:text-gray-400 mb-4">
            출처: <a href={data.sourceUrl || '#'} target="_blank" rel="noopener noreferrer" className="text-blue-500 hover:underline">{data.sourceName} <ExternalLink className="inline w-3 h-3 ml-1" /></a>
          </p>
        )}

        {data.relatedLinks && data.relatedLinks.length > 0 && (
          <div>
            <h4 className="font-semibold text-gray-700 dark:text-white mb-2 text-sm">관련 링크</h4>
            <ul className="space-y-1">
              {data.relatedLinks.map((link, index) => (
                <li key={index}>
                  <a href={link.url} target="_blank" rel="noopener noreferrer" className="text-sm text-blue-500 hover:underline flex items-center">
                    <LinkIcon className="w-3 h-3 mr-2 flex-shrink-0" />
                    {link.text}
                  </a>
                </li>
              ))}
            </ul>
          </div>
        )}
      </div>
    );
  };

  const ResultsPage = () => (
    <div className="container mx-auto px-4 sm:px-6 lg:px-8 py-8">
      {isLoading ? (
        <div className="flex justify-center items-center h-64">
          <div className="animate-spin rounded-full h-16 w-16 border-t-4 border-b-4 border-blue-500"></div>
        </div>
      ) : searchResults.length > 0 ? (
        <div className="flex flex-col lg:flex-row gap-8">
          <div className="w-full lg:w-3/5 xl:w-2/3">
            <p className="text-sm text-gray-600 dark:text-gray-400 mb-4">
              '{searchTerm}'에 대한 약 {searchResults.length}개의 결과를 찾았습니다.
            </p>
            <div className="space-y-6">
              {searchResults.map((result) => (
                <div 
                  key={result.id} 
                  className="p-6 bg-white dark:bg-gray-800 rounded-lg shadow-md hover:shadow-lg transition-shadow cursor-pointer"
                  onClick={() => handleResultItemClick(result)}
                >
                  <h3 className="text-xl font-semibold text-blue-600 dark:text-blue-400 mb-1">
                    <a href={result.url || '#'} onClick={(e) => e.preventDefault()} className="hover:underline">{result.title}</a>
                  </h3>
                  <p className="text-green-600 dark:text-green-400 text-xs mb-2">{result.url || '출처 정보 없음'}</p>
                  <p className="text-gray-700 dark:text-gray-300 mb-3 text-sm">{result.description}</p>
                  <div className="text-xs text-gray-500 dark:text-gray-400">
                    <span>출처: {result.source}</span> | <span>최종 업데이트: {result.lastUpdated}</span> | <span>유형: {result.type}</span>
                  </div>
                </div>
              ))}
            </div>
          </div>
          <KnowledgePanel data={knowledgePanelData} />
        </div>
      ) : (
        <div className="text-center py-12">
          <Search className="w-16 h-16 mx-auto text-gray-400 dark:text-gray-500 mb-4" />
          <h2 className="text-2xl font-semibold text-gray-700 dark:text-gray-200 mb-2">검색 결과가 없습니다.</h2>
          <p className="text-gray-500 dark:text-gray-400">다른 키워드로 검색해 보세요.</p>
        </div>
      )}
    </div>
  );

  const TrendsPage = () => (
    <div className="container mx-auto px-4 sm:px-6 lg:px-8 py-12">
      <div className="text-center mb-12">
        <h2 className="text-4xl font-bold text-gray-800 dark:text-white mb-3">기술 트렌드 분석</h2>
        <p className="text-lg text-gray-600 dark:text-gray-300">주요 기술 키워드에 대한 심층적인 트렌드 정보를 확인하세요.</p>
      </div>
      
      <div className="grid md:grid-cols-2 gap-8">
        {/* 트렌드 카드 예시 (기존과 동일) */}
        <div className="bg-white dark:bg-gray-800 p-6 rounded-xl shadow-lg">
          <h3 className="text-xl font-semibold text-gray-700 dark:text-white mb-4 flex items-center">
            <BarChart2 className="w-6 h-6 mr-2 text-blue-500" />
            인공지능(AI) 기술 트렌드
          </h3>
          <div className="h-64 bg-gray-100 dark:bg-gray-700 rounded-md flex items-center justify-center">
            <p className="text-gray-500 dark:text-gray-400">AI 트렌드 차트 (예정)</p>
          </div>
          <p className="mt-4 text-sm text-gray-600 dark:text-gray-300">
            최근 1년간 AI 관련 기술의 언급량, 주요 연구 분야, 시장 성장 예측 등을 시각화하여 제공합니다.
          </p>
        </div>
        <div className="bg-white dark:bg-gray-800 p-6 rounded-xl shadow-lg">
          <h3 className="text-xl font-semibold text-gray-700 dark:text-white mb-4 flex items-center">
            <BarChart2 className="w-6 h-6 mr-2 text-green-500" />
            클라우드 컴퓨팅 동향
          </h3>
          <div className="h-64 bg-gray-100 dark:bg-gray-700 rounded-md flex items-center justify-center">
            <p className="text-gray-500 dark:text-gray-400">클라우드 트렌드 차트 (예정)</p>
          </div>
           <p className="mt-4 text-sm text-gray-600 dark:text-gray-300">
            퍼블릭, 프라이빗, 하이브리드 클라우드 시장의 변화와 주요 기술 스택의 채택률 변화를 보여줍니다.
          </p>
        </div>
      </div>
       <div className="mt-12 text-center">
        <p className="text-gray-600 dark:text-gray-300">더 많은 트렌드 분석 기능이 곧 추가될 예정입니다.</p>
      </div>
    </div>
  );

  const Footer = () => (
    <footer className="bg-gray-50 dark:bg-gray-900 border-t border-gray-200 dark:border-gray-700 mt-auto">
      <div className="container mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8 mb-8">
          <div>
            <h5 className="font-semibold text-gray-700 dark:text-white mb-3 flex items-center"><Info className="w-5 h-5 mr-2" />플랫폼 정보</h5>
            <ul className="space-y-2">
              <li><a href="#" className="text-sm text-gray-600 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400">소개</a></li>
              <li><a href="#" className="text-sm text-gray-600 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400">데이터 출처</a></li>
            </ul>
          </div>
          <div>
            <h5 className="font-semibold text-gray-700 dark:text-white mb-3 flex items-center"><HelpCircle className="w-5 h-5 mr-2" />지원</h5>
            <ul className="space-y-2">
              <li><a href="#" className="text-sm text-gray-600 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400">자주 묻는 질문</a></li>
              <li><a href="#" className="text-sm text-gray-600 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400">API 사용 가이드</a></li>
            </ul>
          </div>
          <div>
            <h5 className="font-semibold text-gray-700 dark:text-white mb-3 flex items-center"><Shield className="w-5 h-5 mr-2" />법적 고지</h5>
            <ul className="space-y-2">
              <li><a href="#" className="text-sm text-gray-600 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400">개인정보처리방침</a></li>
              <li><a href="#" className="text-sm text-gray-600 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400">이용약관</a></li>
            </ul>
          </div>
        </div>
        <div className="text-center text-sm text-gray-500 dark:text-gray-400 pt-8 border-t border-gray-200 dark:border-gray-700">
          &copy; {new Date().getFullYear()} 데이터 파인더. All rights reserved.
        </div>
      </div>
    </footer>
  );
  
  return (
    <div className="flex flex-col min-h-screen bg-gray-50 dark:bg-gray-950 text-gray-800 dark:text-gray-100 transition-colors duration-300 font-sans">
      <Header />
      <main className="flex-grow">
        {currentPage === 'home' && <HomePage />}
        {currentPage === 'results' && <ResultsPage />}
        {currentPage === 'trends' && <TrendsPage />}
      </main>
      <Footer />
    </div>
  );
};

export default App;
