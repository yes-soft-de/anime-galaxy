import { Component, OnInit } from '@angular/core';
import { ToastrService } from 'ngx-toastr';
import { AnimeService } from 'src/app/pages/animes/services/anime.service';
import { AnimeHighestRating } from '../../entity/anime-highest-rating';
import { AnimeHighestRatingResponse } from '../../entity/anime-highest-rating-response';
import { SuggestService } from '../../services/suggest.service';

@Component({
  selector: 'app-hightest-rated-anime',
  templateUrl: './hightest-rated-anime.component.html'
})
export class HightestRatedAnimeComponent implements OnInit {

  animehighestRating: AnimeHighestRating[];
  animehighestRatingList: AnimeHighestRating[] = [];
  animehighestRatingFilterList: AnimeHighestRating[] = [];         // We Create It Second For Filter
  suggestProgress = false;
  isDeleted = false;
  config: any;                    // Config Variable For Pagination Configuration
  name: string;                   // name variable to store the input search value

  constructor(private suggestService: SuggestService,
              private animeService: AnimeService,    
              private toaster: ToastrService ) { }

  ngOnInit() {
    this.getAnimes();
  }


  getAnimes() {
    // Fetch All Items 
    this.suggestService.allHightestRatedAnime().subscribe(
      (data: AnimeHighestRatingResponse) => {
        if (data) {
          this.animehighestRating = data.Data;
          this.animehighestRatingList = data.Data;
        }
      }, 
      error1 => this.handleError(error1), 
      () => {
        this.animehighestRatingFilterList = this.animehighestRatingList;
      });

    this.config = {
      itemsPerPage: 5,
      currentPage: 1,
      totalItems: this.animehighestRatingList.length
    };
   
  }

    // Handle Response Error
    handleError(error) {
      console.log(error);
      this.animehighestRating = [];
      if (error.error.error) {
        this.toaster.error(error.error.error);
      } else if (error.error.msg) {
        this.toaster.error(error.error.msg);
      }
    }

  // Fetch The Page Number On Page Change
  pageChanged(event) {
    this.config.currentPage = event;
  }

  // Delete The Anime
  delete(animeId: number) {
    if (confirm('Are You Sure You Want To Delete This Anime')) {
      this.isDeleted = true;
      this.animeService.deleteAnime(animeId).subscribe(
        data => {
          this.toaster.success('Anime Successfully Deleted');
          console.log('deleted Successfully: ', data);
        },
        error => {
          this.isDeleted = false;
          console.log('error : ', error);
          this.toaster.error('There Is An Error Please Try Again');
        }, () => {
          this.isDeleted = false;
          this.getAnimes();
        }
      );
    } else {
      return false;
    }
  }

  suggest(animeID: number, isSuggest: boolean) {
    this.suggestProgress = true;
    this.suggestService.animeSuggest(animeID, isSuggest).subscribe(
      suggestResponse => {
        this.getAnimes();
        this.suggestProgress = false;
      },
      error => console.log(error)
    );
  }


  applyFilter() {
    // if the search input value is empty
    if (!this.name) {
      this.animehighestRatingFilterList = [...this.animehighestRatingList];
    } else {
      this.animehighestRatingFilterList = [];
      this.animehighestRatingFilterList = this.animehighestRatingList.filter(res => {
        // Search In Name Column
        const nameResult = res.animeName.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
        // Search In Name Column
        const categoryName = res.categoryName.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
        if (nameResult) {
          // display the Name Column
          return nameResult;
        } else if (categoryName) {
          // display the Name Column
          return categoryName;
        }
      });
    }
  }

}
